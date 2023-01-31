//
//  AddEmployeeVM.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import IQKeyboardManagerSwift

class AddEmployeeVM {
    
    weak var binder: AddEmployeeBinder?
    
    private var model: AddEmployeeModel?
    
    init(binder: AddEmployeeBinder) {
        self.binder = binder
        self.model = AddEmployeeModel()
    }
    
    func main() {
        binder?.configureProfilePciture()
        binder?.configurePicker()
        binder?.configureAddButton()
        binder?.configureTextField()
        binder?.txtDepartment?.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        binder?.getData(model: self.model!)
    }
    
    func addImage() {
        binder?.addImage()
    }
    
    func addEmployeeInformation() {
        binder?.addEmployeeInformation()
    }
    
    func showPopUp() {
        binder?.showPopUp()
    }
    
    deinit {
        self.model = nil
//        self.binder = nil
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        binder?.doneButtonClicked(sender as! UITextField)
    }
}
