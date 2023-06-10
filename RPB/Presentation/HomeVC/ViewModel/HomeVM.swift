//
//  HomeVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit

class HomeVM {
    
    //MARK: Variables
    weak var binder: HomeBinder?
    weak var viewController: UIViewController?
    private var model: HomeModel?
    
    //MARK: Init
    init(binder: HomeBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    var employeeLimit: String = "\(5)"
    
    //MARK: Main Function
    func main() {
        binder?.configureFonts()
        binder?.configTableView()
        binder?.didTapProfileAt = { [weak self] (id) in
            self?.navigateProfileScreen(id: id)
        }
    }
    
    //MARK: Navigate to All Employees
    func navigateToEmployees() {
        let tabbarVC = UIStoryboard.getVC(from: .main, TabbarVC.className) as! TabbarVC
        tabbarVC.isNavigationEmployee = true
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Navigate to Add Employee Screen
    func navigateAddEmployeeScreen() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, AddEmployeeVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Navigate to Employee Detail Screen
    func navigateProfileScreen(id: String) {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ProfileVC.className) as! ProfileVC
        let profileVM = ProfileVM(employeeId: id)
        tabbarVC.viewModel = profileVM
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: API Calling Function
    func apiCall() {
        self.fetchEmployeeListing()
        self.employeeDashboard()
    }
    
    //MARK: API Calling for Employee Listing
    func fetchEmployeeListing() {
        let bodyParams = [ParameterKeys.limit: self.employeeLimit]
        UserService.shared.fetchEmployeeListing(params: bodyParams) { response in
            switch response {
            case .success(let userResponse):
                self.binder?.employeeListing = userResponse
                self.binder?.tableView?.reloadWithAnimation()
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
    
    //MARK: API Calling for Total number of Employees
    func employeeDashboard() {
        DispatchQueue.main.async {
            UserService.shared.fetchEmployeeCount { response in
                switch response {
                case .success(let userResponse):
                    self.model = userResponse
                    self.binder?.endValue = self.model?.data?.totalEmployees ?? 0
                    self.binder?.incrementedValue()
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
}
