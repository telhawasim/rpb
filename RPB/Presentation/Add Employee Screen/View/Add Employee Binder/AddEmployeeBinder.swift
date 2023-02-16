//
//  AddEmployeeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation

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
    weak var txtPhone: UITextField?
    weak var txtDepartment: UITextField?
    weak var txtDateOfJoining: UITextField?
    weak var designationIcon: UIImageView?
    weak var departmentIcon: UIImageView?
    weak var dobIcon: UIImageView?
    weak var dateOfJoiningIcon: UIImageView?
    weak var viewController: UIViewController?
    var model: AddEmployeeModel?
        
    init(lblTitle: UILabel, profileImage: UIImageView, lblName: UILabel, lblDesignation: UILabel, lblDepartment: UILabel, lblDOB: UILabel, lblEmail: UILabel, lblPhone: UILabel, lblDateOfJoining: UILabel, btnAdd: UIButton, txtName: UITextField, txtDesignation: UITextField, txtDOB: UITextField, txtEmail: UITextField, txtPhone: UITextField, txtDepartment: UITextField, txtDateOfJoining: UITextField, designationIcon: UIImageView, departmentIcon: UIImageView, dobIcon: UIImageView, dateOfJoiningIcon: UIImageView, viewController: UIViewController) {
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
    let designationData: [String] = ["Graphic Designer", "Principal Designer", "Junior UI/UX Designer"]
    let departmentdata: [String] = ["Development","Testing","Creative","Management"]
    
    // MARK: Get Data
    func getData(model: AddEmployeeModel) {
        self.model = model
    }
    
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
        self.txtName?.font = UIFont.getMediumFont()
        self.txtDesignation?.font = UIFont.getMediumFont()
        self.txtDepartment?.tintColor = .clear
        self.txtDOB?.font = UIFont.getMediumFont()
        self.txtDOB?.tintColor = .clear
        self.txtEmail?.font = UIFont.getMediumFont()
        self.txtPhone?.font = UIFont.getMediumFont()
        self.txtDepartment?.font = UIFont.getMediumFont()
        self.txtDateOfJoining?.font = UIFont.getMediumFont()
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
        self.btnAdd?.cornerRadius(30)
        self.btnAdd?.backgroundColor = UIColor.customBlue
        self.btnAdd?.setTitleColor(UIColor.white, for: .normal)
        self.btnAdd?.titleLabel?.font = UIFont.getMediumFont(size: 18)
    }
    
    // MARK: Configure TextField
    func configureTextField() {
        txtDesignation?.delegate = self
        txtDepartment?.delegate = self
        txtDOB?.delegate = self
        txtDateOfJoining?.delegate = self
        txtPhone?.delegate = self
    }
    
    //MARK: TextField Validation
    func checkValidation() -> Bool {
        guard let name = txtName?.text,
              let designation = txtDesignation?.text,
              let department = txtDepartment?.text,
              let dob = txtDOB?.text,
              let email = txtEmail?.text,
              let phone = txtPhone?.text,
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
        } else if phone.count > 11 {
            errorMessage = Localization.AddEmployee.kPhoneLengthError
        } else if dateOfJoining.isEmpty {
            errorMessage = Localization.AddEmployee.kDateOfJoiningEmptyError
        }
        
        if let errorMsg = errorMessage {
            AlertHandler.shared.alert(message: errorMsg)
            return false
        }
        return true
    }
    
    func addImage() {
        CameraHandler.shared.showActionSheet(viewC: viewController ?? UIViewController())
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.profileImage?.image = image
        }
    }
    
    func addEmployeeInformation() {
        if checkValidation() {
//            let tabbarVC  = UIStoryboard.getVC(from: .main, TabbarVC.className)
//            viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
    
    func showPopUp() {
        PopupView.shared.presentCancelPopup(viewController ?? UIViewController(), popupType: .discardInformation) { value in
            if (value != nil) {
                self.viewController?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func tapDoneDOB() {
        guard let datePicker = self.txtDOB?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        if !date.is18Plus() {
            self.txtDOB?.text = nil
            AlertHandler.shared.alert(message: Localization.AddEmployee.kEmployeeAgeError)
            return
        }
        
        self.txtDOB?.text = date.getFormattedDate(format: "dd-MM-yyyy")
        self.txtDOB?.resignFirstResponder()
    }
    
    @objc func tabDoneJoining() {
        guard let datePicker = self.txtDateOfJoining?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        self.txtDateOfJoining?.text = date.getFormattedDate(format: "dd-MM-yyyy")
        self.txtDateOfJoining?.resignFirstResponder()
    }
    
    func doneButtonClicked(_ sender: UITextField) {
        if sender == txtDepartment {
            let selectedRow = departmentpicker.selectedRow(inComponent: 0)
            let selectedValue = departmentpicker.delegate?.pickerView?(departmentpicker, titleForRow: selectedRow, forComponent: 0)
            self.txtDepartment?.text = selectedValue
        } else {
            let selectedRow = designationPicker.selectedRow(inComponent: 0)
            let selectedValue = designationPicker.delegate?.pickerView?(designationPicker, titleForRow: selectedRow, forComponent: 0)
            self.txtDesignation?.text = selectedValue
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
            return designationData.count
        } else {
            return departmentdata.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == designationPicker {
            return designationData[row]
        } else {
            return departmentdata[row]
        }
    }
}

// MARK: TextField Methods
extension AddEmployeeBinder: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDesignation {
            designationIcon?.image = UIImage.dropdownArrowUp
        } else if textField == txtDepartment {
            departmentIcon?.image = UIImage.dropdownArrowUp
        } else if textField == txtDOB {
            dobIcon?.image = UIImage.dropdownArrowUp
        } else if textField == txtDateOfJoining {
            dateOfJoiningIcon?.image = UIImage.dropdownArrowUp
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtDesignation {
            designationIcon?.image = UIImage.dropdownArrowDown
        } else if textField == txtDepartment {
            departmentIcon?.image = UIImage.dropdownArrowDown
        } else if textField == txtDOB {
            dobIcon?.image = UIImage.dropdownArrowDown
        } else if textField == txtDateOfJoining {
            dateOfJoiningIcon?.image = UIImage.dropdownArrowDown
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhone {
            let maxLength = 11
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            
            return newString.count <= maxLength
        } else {
            return true
        }
    }
}
