//
//  EmployeeVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class EmployeeVM {
    
    //MARK: Variables
    weak var binder: EmployeeBinder?
    weak var viewController: UIViewController?
    
    init(binder: EmployeeBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    
    init(id: String) {
        self.id = id
    }
    
    var id: String?
    var currentPage = 1
    
    //MARK: Main Function
    func main() {
        binder?.configureFonts()
        binder?.configureTextField()
        binder?.setColors()
        binder?.configureBottomSheet()
        binder?.registerCell()
        binder?.didTapProfileAt = { [weak self] (id) in
            self?.goToProfile(id: id)
        }
        binder?.didTapFilterAt = { (id, page, empSearch) in
            self.fetchFiltersEmployee(id: id, page: page, searchText: empSearch)
        }
        binder?.showPagination = { (page) in
            self.currentPage = page
            self.fetchEmployeeListing(page: self.currentPage)
        }
        binder?.didShowSearch = { (empSearch, id) in
            self.binder?.currentPage = 1
            self.fetchFiltersEmployee(id: id, page: self.binder?.currentPage ?? 0, searchText: empSearch)
        }
        binder?.didRefresh = { (refresh) in
            self.binder?.employeeListing = nil
            self.binder?.currentPage = 1
            self.currentPage = 1
            self.fetchFiltersEmployee(id: self.binder?.departmentID ?? "", page: self.binder?.currentPage ?? 0, searchText: self.binder?.txtSearch?.text ?? "")
            refresh.endRefreshing()
        }
    }
    
    // MARK: Go to Employee VC
    func goToAddEmployee() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, AddEmployeeVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Go to Profile Screen
    func goToProfile(id: String) {
        let profileVC = UIStoryboard.getVC(from: .main, ProfileVC.className) as! ProfileVC
        let profileVM = ProfileVM(employeeId: id)
        profileVC.viewModel = profileVM
        self.viewController?.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    //MARK: API Calling for Employee Listing
    func fetchEmployeeListing(page: Int = 1) {
        DispatchQueue.main.async {
            Loader.start()
        }
        let bodyParam = [ParameterKeys.page: "\(page)"]
        UserService.shared.fetchEmployeeListing(params: bodyParam) { response in
            DispatchQueue.main.async { [self] in
                Loader.stop()
                switch response {
                case .success(let userResponse):
                    if binder?.employeeListing == nil {
                        self.binder?.employeeListing = userResponse
                        self.binder?.tableView?.reloadWithAnimation()
                    } else {
                        if let data = userResponse.data?.employees {
                            self.binder?.employeeListing?.data?.employees?.append(contentsOf: data)
                            self.binder?.tableView?.reloadData()
                        }
                    }
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func fetchFiltersEmployee(id: String = "", page: Int = 1, searchText: String = "") {
        DispatchQueue.main.async {
            Loader.start()
        }
        let bodyParams = [ParameterKeys.id: id, ParameterKeys.page: "\(page)", ParameterKeys.empSearch: searchText]
        UserService.shared.fetchFilteredEmployeeListing(params: bodyParams) { response in
            DispatchQueue.main.async {
                Loader.stop()
                switch response {
                case .success(let userResponse):
                    self.binder?.employeeListing = nil
                    if self.binder?.employeeListing == nil {
                        self.binder?.employeeListing = userResponse
                    } else {
                        self.binder?.employeeListing?.data?.employees?.append(contentsOf: (userResponse.data?.employees)!)
                    }
                    self.binder?.tableView?.reloadWithAnimation()
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
        
    //MARK: API Calling for Department
    func fetchDepartments() {
        UserService.shared.fetchDepartments { response in
            switch response {
            case .success(let userResponse):
                self.binder?.departments = userResponse.departments
                self.binder?.collectionView?.reloadData()
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
}
