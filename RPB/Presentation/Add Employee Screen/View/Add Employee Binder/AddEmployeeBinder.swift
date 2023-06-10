//
//  AddEmployeeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import FlagPhoneNumber

class AddEmployeeBinder: NSObject {
        
    //MARK: Variables
    weak var lblTitle: UILabel?
    weak var profileImage: UIImageView?
    weak var lblName: UILabel?
    weak var lblDesignation: UILabel?
    weak var lblDepartment: UILabel?
    weak var lblDOB: UILabel?
    weak var lblEmail: UILabel?
    weak var lblPhone: UILabel?
    weak var lblDateOfJoining: UILabel?
    weak var btnAdd: UIButton?
    weak var txtName: UITextField?
    weak var txtDesignation: UITextField?
    weak var txtDOB: UITextField?
    weak var txtEmail: UITextField?
    weak var txtPhone: FPNTextField?
    weak var txtDepartment: UITextField?
    weak var txtDateOfJoining: UITextField?
    weak var designationIcon: UIImageView?
    weak var departmentIcon: UIImageView?
    weak var dobIcon: UIImageView?
    weak var dateOfJoiningIcon: UIImageView?
    weak var viewController: UIViewController?
        
    init(lblTitle: UILabel, profileImage: UIImageView, lblName: UILabel, lblDesignation: UILabel, lblDepartment: UILabel, lblDOB: UILabel, lblEmail: UILabel, lblPhone: UILabel, lblDateOfJoining: UILabel, btnAdd: UIButton, txtName: UITextField, txtDesignation: UITextField, txtDOB: UITextField, txtEmail: UITextField, txtPhone: FPNTextField, txtDepartment: UITextField, txtDateOfJoining: UITextField, designationIcon: UIImageView, departmentIcon: UIImageView, dobIcon: UIImageView, dateOfJoiningIcon: UIImageView, viewController: UIViewController) {
        self.lblTitle = lblTitle
        self.profileImage = profileImage
        self.lblName = lblName
        self.lblDesignation = lblDesignation
        self.lblDepartment = lblDepartment
        self.lblDOB = lblDOB
        self.lblEmail = lblEmail
        self.lblPhone = lblPhone
        self.lblDateOfJoining = lblDateOfJoining
        self.btnAdd = btnAdd
        self.txtName = txtName
        self.txtDesignation = txtDesignation
        self.txtDOB = txtDOB
        self.txtEmail = txtEmail
        self.txtPhone = txtPhone
        self.txtDepartment = txtDepartment
        self.txtDateOfJoining = txtDateOfJoining
        self.designationIcon = designationIcon
        self.departmentIcon = departmentIcon
        self.dobIcon = dobIcon
        self.dateOfJoiningIcon = dateOfJoiningIcon
        self.viewController = viewController
    }
    let designationPicker = UIPickerView()
    let departmentpicker = UIPickerView()
    
    var departments: [Departments]?
    var designations: [Departments]?
    var selectedDepartment: Departments?
    var selectedDesignation: Departments?
    var employeeImage: EmployeeImageModel?
    var phoneNumber: String = ""
    var isPhoneValid: Bool?
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)

    
    // MARK: Configure Font
    func configureFont() {
        self.lblTitle?.font = UIFont.getMediumFont(size: 24)
        self.lblName?.font = UIFont.getSemiBoldFont()
        self.lblDesignation?.font = UIFont.getSemiBoldFont()
        self.lblDepartment?.font = UIFont.getSemiBoldFont()
        self.lblDOB?.font = UIFont.getSemiBoldFont()
        self.lblEmail?.font = UIFont.getSemiBoldFont()
        self.lblPhone?.font = UIFont.getSemiBoldFont()
        self.lblDateOfJoining?.font = UIFont.getSemiBoldFont()
        self.txtName?.font = UIFont.getRegularFont()
        self.txtDesignation?.font = UIFont.getRegularFont()
        self.txtDesignation?.tintColor = .clear
        self.txtDepartment?.font = UIFont.getRegularFont()
        self.txtDepartment?.tintColor = .clear
        self.txtDOB?.font = UIFont.getRegularFont()
        self.txtDOB?.tintColor = .clear
        self.txtEmail?.font = UIFont.getRegularFont()
        self.txtPhone?.font = UIFont.getRegularFont()
        self.txtDateOfJoining?.font = UIFont.getRegularFont()
        self.txtDateOfJoining?.tintColor = .clear
    }
    
    // MARK: Configure Profile Picture
    func configureProfilePciture() {
        self.profileImage?.isCircularImage()
    }
    
    // MARK: Configure Picker for Department
    func configurePicker() {
        self.designationPicker.delegate = self
        self.txtDesignation?.inputView = designationPicker
        self.departmentpicker.delegate = self
        self.txtDepartment?.inputView = departmentpicker
        self.txtDOB?.setInputViewDatePicker(target: self, selector: #selector(tapDoneDOB))
        self.txtDateOfJoining?.setInputViewDatePicker(target: self, selector: #selector(tabDoneJoining))
    }
    
    // MARK: Configure Add Button
    func configureAddButton() {
        self.btnAdd?.cornerRadius(25)
        self.btnAdd?.backgroundColor = UIColor.appColor
        self.btnAdd?.setTitleColor(UIColor.white, for: .normal)
        self.btnAdd?.titleLabel?.font = UIFont.getBoldFont(size: 16)
    }
    
    // MARK: Configure TextField
    func configureTextField() {
        txtName?.delegate = self
        txtDesignation?.delegate = self
        txtDepartment?.delegate = self
        txtPhone?.delegate = self
        txtPhone?.tintColor = UIColor.appColor
        txtPhone?.setFlag(key: .PK)
        txtPhone?.displayMode = .list
        listController.setup(repository: txtPhone?.countryRepository ?? FPNCountryRepository())
        listController.didSelect = { [weak self] country in
            self?.txtPhone?.setFlag(countryCode: country.code)
        }
        txtEmail?.autocorrectionType = .no
        txtEmail?.keyboardType = .emailAddress
        txtDepartment?.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        txtDesignation?.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
    }
    
    //MARK: TextField Validation
    func checkValidation() -> Bool {
        guard let name = txtName?.text,
              let designation = txtDesignation?.text,
              let department = txtDepartment?.text,
              let dob = txtDOB?.text,
              let email = txtEmail?.text,
              let isPhoneValid = self.isPhoneValid,
              let phone = self.txtPhone?.text,
              let dateOfJoining = txtDateOfJoining?.text else {
            return false
        }
        var errorMessage: String?
        
        if name.isEmpty {
            errorMessage = Localization.AddEmployee.kNameEmptyError
        } else if designation.isEmpty {
            errorMessage = Localization.AddEmployee.kDesignationEmptyError
        } else if department.isEmpty {
            errorMessage = Localization.AddEmployee.kDepartmentEmptyError
        } else if dob.isEmpty {
            errorMessage = Localization.AddEmployee.kDobEmptyError
        } else if email.isEmpty {
            errorMessage = Localization.Login.kEmailEmptyError
        } else if !email.isEmailValid() {
            errorMessage = Localization.Login.kEmailInvalidError
        } else if phone.isEmpty {
            errorMessage = Localization.AddEmployee.kPhoneEmptyError
        } else if !isPhoneValid {
            errorMessage = Localization.AddEmployee.kPhoneValidationError
        } else if dateOfJoining.isEmpty {
            errorMessage = Localization.AddEmployee.kDateOfJoiningEmptyError
        }
        
        if let errorMsg = errorMessage {
            AlertHandler.shared.alert(message: errorMsg)
            return false
        }
        return true
    }
    
    func validationForEmptyTextFields() -> Bool {
        guard let name = txtName?.text,
              let designations = txtDesignation?.text,
              let departments = txtDepartment?.text,
              let dob = txtDOB?.text,
              let email = txtEmail?.text,
              let phone = txtPhone?.text,
              let dateOfJoining = txtDateOfJoining?.text else {
            return false
        }
        
        if name.isEmpty && designations.isEmpty && departments.isEmpty && dob.isEmpty && email.isEmpty && phone.isEmpty && dateOfJoining.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    //MARK: Done Button For DOB Picker
    @objc func tapDoneDOB() {
        guard let datePicker = self.txtDOB?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
//        if !date.is10Plus() {
//            self.txtDOB?.text = nil
//            AlertHandler.shared.alert(message: Localization.AddEmployee.kEmployeeAgeError)
//            return
//        }
        
        self.txtDOB?.text = date.getFormattedDate(format: DateFormat.eeee_mmm_d_yyyy)
        self.txtDOB?.resignFirstResponder()
    }
    
    //MARK: Done Button For Date Of Joining Picker
    @objc func tabDoneJoining() {
        guard let datePicker = self.txtDateOfJoining?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        self.txtDateOfJoining?.text = date.getFormattedDate(format: DateFormat.eeee_mmm_d_yyyy)
        self.txtDateOfJoining?.resignFirstResponder()
    }
    
    //MARK: Done Button for Departments and Designations
    @objc func doneButtonClicked(_ sender: UITextField) {
        if sender == txtDepartment {
            self.selectedDepartment = self.departments?[departmentpicker.selectedRow(inComponent: 0)]
            self.txtDepartment?.text = self.selectedDepartment?.title
        } else {
            self.selectedDesignation = self.designations?[designationPicker.selectedRow(inComponent: 0)]
            self.txtDesignation?.text = self.selectedDesignation?.title
        }
    }
}

// MARK: UIPicker Methods
extension AddEmployeeBinder: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == designationPicker {
            return designations?.count ?? 0
        } else {
            return departments?.count ?? 0
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == designationPicker {
            return designations?[row].title
        } else {
            return departments?[row].title
        }
    }
}

// MARK: TextField Methods
extension AddEmployeeBinder: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        var imageView: UIImageView?
        let arrowImage: UIImage = UIImage.dropdownArrowUp
        
        if textField == txtDesignation {
            imageView = designationIcon
        } else if textField == txtDepartment {
            imageView = departmentIcon
        }
        
        if let imageView = imageView {
            UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve) {
                imageView.image = arrowImage
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var imageView: UIImageView?
        let arrowImage: UIImage = UIImage.dropdownArrowDown
        
        if textField == txtDesignation {
            imageView = designationIcon
        } else if textField == txtDepartment {
            imageView = departmentIcon
        }
        
        if let imageView = imageView {
            UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve) {
                imageView.image = arrowImage
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtName {
            let maxLength = 50
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)

            return newString.count <= maxLength
        } else {
            return true
        }
    }
}

extension AddEmployeeBinder: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
//        self.selectedCountryCode = code
    }
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(dismissCountries))
        
        listController.navigationItem.leftBarButtonItem = leftButton
        listController.title = "Countries"
        
        self.viewController?.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        isPhoneValid = isValid
        if isValid {
            self.phoneNumber = textField.getFormattedPhoneNumber(format: .E164) ?? ""
        } else {
            self.phoneNumber = ""
        }
    }
    
    @objc func dismissCountries() {
        listController.dismiss(animated: true, completion: nil)
    }
}
