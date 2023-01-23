//
//  AddEmployeeVC.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import UIKit
import IQKeyboardManagerSwift

class AddEmployeeVC: BaseVC {
    
    // MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblDateOfJoining: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtDateOfJoining: UITextField!
    @IBOutlet weak var dropDownIcon: UIImageView!
    
    // MARK: Variables
    let departmentpicker = UIPickerView()
    let departmentdata: [String] = ["Development","Testing","Creative","Management"]
    
    // MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFont()
        self.configureAddButton()
        self.configureProfilePciture()
        self.configurePicker()
        self.configureTextField()
        self.swipeToPop()
        self.txtDepartment.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
    }
    
    // MARK: Configure Font
    func configureFont() {
        self.lblTitle.font = UIFont.getMediumFont(size: 24)
        self.lblName.font = UIFont.getSemiBoldFont()
        self.lblDesignation.font = UIFont.getSemiBoldFont()
        self.lblDepartment.font = UIFont.getSemiBoldFont()
        self.lblDOB.font = UIFont.getSemiBoldFont()
        self.lblEmail.font = UIFont.getSemiBoldFont()
        self.lblPhone.font = UIFont.getSemiBoldFont()
        self.lblDateOfJoining.font = UIFont.getSemiBoldFont()
        self.txtName.font = UIFont.getMediumFont()
        self.txtDesignation.font = UIFont.getMediumFont()
        self.txtDepartment.tintColor = .clear
        self.txtDOB.font = UIFont.getMediumFont()
        self.txtDOB.tintColor = .clear
        self.txtEmail.font = UIFont.getMediumFont()
        self.txtPhone.font = UIFont.getMediumFont()
        self.txtDepartment.font = UIFont.getMediumFont()
        self.txtDateOfJoining.font = UIFont.getMediumFont()
        self.txtDateOfJoining.tintColor = .clear
    }
    
    // MARK: Configure Profile Picture
    func configureProfilePciture() {
        self.profileImage.isCircularImage()
    }
    
    // MARK: Configure Picker for Department
    func configurePicker() {
        self.departmentpicker.delegate = self
        self.txtDepartment.inputView = departmentpicker
        self.txtDOB.setInputViewDatePicker(target: self, selector: #selector(tapDoneDOB))
        self.txtDateOfJoining.setInputViewDatePicker(target: self, selector: #selector(tabDoneJoining))
    }
    
    // MARK: Configure Add Button
    func configureAddButton() {
        self.btnAdd.cornerRadius(30)
        self.btnAdd.backgroundColor = UIColor.customBlue
        self.btnAdd.setTitleColor(UIColor.white, for: .normal)
        self.btnAdd.titleLabel?.font = UIFont.getMediumFont(size: 18)
    }
    
    // MARK: Configure TextField
    func configureTextField() {
        txtDepartment.delegate = self
        txtPhone.delegate = self
    }
    
    func swipeToPop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func checkValidation() -> Bool {
        guard let name = txtName.text,
              let designation = txtDesignation.text,
              let department = txtDepartment.text,
              let dob = txtDOB.text,
              let email = txtEmail.text,
              let phone = txtPhone.text,
              let dateOfJoining = txtDateOfJoining.text else {
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
            self.alert(message: errorMsg)
            return false
        }
        return true
    }
    
    @objc func tapDoneDOB() {
        guard let datePicker = self.txtDOB.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        if !date.is18Plus() {
            self.txtDOB.text = nil
            self.alert(message: Localization.AddEmployee.kEmployeeAgeError)
            return
        }
        
        self.txtDOB.text = date.getFormattedDate(format: "dd-MM-yyyy")
        self.txtDOB.resignFirstResponder()
    }
    
    @objc func tabDoneJoining() {
        guard let datePicker = self.txtDateOfJoining.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        self.txtDateOfJoining.text = date.getFormattedDate(format: "dd-MM-yyyy")
        self.txtDateOfJoining.resignFirstResponder()
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        if txtDepartment.text == "" {
            self.departmentpicker.selectRow(0, inComponent: 0, animated: true)
            self.txtDepartment.text = self.departmentdata.first
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if checkValidation() {
            
        }
    }
    
    @IBAction func addBtnImage(_ sender: Any) {
        CameraHandler.shared.showActionSheet(viewC: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.profileImage.image = image
        }
    }
    
    @IBAction func tappedShowPopUp(_ sender: Any) {
        PopupView.shared.presentPopup(self, popupType: .discardInformation) { value in
            if (value != nil) {
                self.goBack()
            }
        }
    }
}

// MARK: UIPicker Methods
extension AddEmployeeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departmentdata.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departmentdata[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtDepartment.text = departmentdata[row]
        //        self.view.endEditing(true)
    }
}

// MARK: TextField Methods
extension AddEmployeeVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dropDownIcon.image = UIImage.dropdownArrowUp
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dropDownIcon.image = UIImage.dropdownArrowDown
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhone {
            let maxLength = 11
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            
            return newString.count <= maxLength
        } else {
            return Bool()
        }
    }
}
