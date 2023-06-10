//
//  AddEmployeeVM.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import IQKeyboardManagerSwift

class AddEmployeeVM {
    
    //MARK: Variables
    weak var binder: AddEmployeeBinder?
    weak var viewController: UIViewController?
    
    init(binder: AddEmployeeBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    var imgURL: String?
    
    //MARK: Main Function
    func main() {
        binder?.configureFont()
        binder?.configureProfilePciture()
        binder?.configurePicker()
        binder?.configureAddButton()
        binder?.configureTextField()
    }
    
    //MARK: Add Image
    func addImage() {
        CameraHandler.shared.showActionSheet(viewC: viewController ?? UIViewController())
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.binder?.profileImage?.image = image
            self.uploadImage(image: image) { imgURL in
                self.imgURL = imgURL ?? ""
                if let url = imgURL {
                    self.binder?.profileImage?.setImage(url: url)
                } else {
                    self.binder?.profileImage?.image = UIImage(named: "user.png")
                }
            }
        }
    }
    
    //MARK: Show PopUP
    func showPopUp() {
        PopupView.shared.presentCancelPopup(viewController ?? UIViewController(), popupType: .discardInformation) { value in
            if (value != nil) {
                self.viewController?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: Go Back
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    //MARK: API Calling for Adding Profile Image
    func uploadImage(image: UIImage, onComplete: @escaping (String?) -> ()) {
        UserService.shared.uploadProfileImage(with: image, parameters: "profilePicture") { response in
            switch response {
            case .success(let url):
                onComplete(url.data?.url)
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
    
    //MARK: API Calling for Adding Employee
    func addEmployeeInformation() {
        guard let validation = binder?.checkValidation(), validation else { return }
        
        let name = binder?.txtName?.text ?? ""
        let designation = binder?.selectedDesignation?._id ?? ""
        let department = binder?.selectedDepartment?._id ?? ""
        let dateOfBirth = binder?.txtDOB?.text?.convertDate(from: DateFormat.eeee_mmm_d_yyyy, to: DateFormat.yyyy_mm_dd) ?? ""
        let email = binder?.txtEmail?.text ?? ""
        let phone = binder?.phoneNumber ?? ""
        let dateOfJoining = binder?.txtDateOfJoining?.text?.convertDate(from: DateFormat.eeee_mmm_d_yyyy, to: DateFormat.yyyy_mm_dd) ?? ""
        
        var bodyParams = [ParameterKeys.name: name,
                          ParameterKeys.designatipn: designation,
                          ParameterKeys.department: department,
                          ParameterKeys.dateOfBirth: dateOfBirth,
                          ParameterKeys.email: email,
                          ParameterKeys.phone: phone,
                          ParameterKeys.dateOfJoining: dateOfJoining
        ]
        
        if let url = self.imgURL {
            bodyParams[ParameterKeys.profilePicture] = url
        }
        
        Loader.start()
        UserService.shared.addEmployee(body: bodyParams) { response in
            Loader.stop()
            DispatchQueue.main.async {
                switch response {
                case .success(let userResponse):
                    _ = userResponse.data?._id ?? ""
                    let profileVC = UIStoryboard.getVC(from: .main, TabbarVC.className) as! TabbarVC
                    self.viewController?.navigationController?.pushViewController(profileVC, animated: true)
                case .failure(let message):
                    AlertHandler.shared.alert(message: message.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Fetching Departments
    func fetchDepartments() {
        UserService.shared.fetchDepartments { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let department):
                    self.binder?.departments = department.departments
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API Calling for Fetching Designations
    func fetchDesignations() {
        UserService.shared.fetchDesignations { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let designation):
                    self.binder?.designations = designation.data?.designations
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
}
