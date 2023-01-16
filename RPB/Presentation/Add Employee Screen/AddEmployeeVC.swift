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
    @IBOutlet weak var dropDown: UIImageView!

    // MARK: Variables
    let departmentpicker = UIPickerView()
    let departmentdata = [String](arrayLiteral: "Development", "Testing", "Creative", "Management")
    
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
        self.lblTitle.font = UIFont.montserratMedium(24)
        self.lblName.font = UIFont.montserratSemiBold(16)
        self.lblDesignation.font = UIFont.montserratSemiBold(16)
        self.lblDepartment.font = UIFont.montserratSemiBold(16)
        self.lblDOB.font = UIFont.montserratSemiBold(16)
        self.lblEmail.font = UIFont.montserratSemiBold(16)
        self.lblPhone.font = UIFont.montserratSemiBold(16)
        self.lblDateOfJoining.font = UIFont.montserratSemiBold(16)
        self.txtName.font = UIFont.montserratMedium(16)
        self.txtDesignation.font = UIFont.montserratMedium(16)
        self.txtDepartment.tintColor = .clear
        self.txtDOB.font = UIFont.montserratMedium(16)
        self.txtEmail.font = UIFont.montserratMedium(16)
        self.txtPhone.font = UIFont.montserratMedium(16)
        self.txtDepartment.font = UIFont.montserratMedium(16)
        self.txtDateOfJoining.font = UIFont.montserratMedium(16)
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
        self.btnAdd.setTitle("Add", for: .normal)
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
            errorMessage = "Please enter name"
        } else if designation.isEmpty {
            errorMessage = "Please enter designation"
        } else if department.isEmpty {
            errorMessage = "Please enter department"
        } else if dob.isEmpty {
            errorMessage = "Please enter date of birth"
        } else if email.isEmpty {
            errorMessage = "Please enter email address"
        } else if !email.isEmailValid() {
            errorMessage = "Please enter valid email address"
        } else if phone.isEmpty {
            errorMessage = "Please enter phone number"
        } else if dateOfJoining.isEmpty {
            errorMessage = "Please enter date of joining"
        }

        if let errorMsg = errorMessage {
            self.alert(message: errorMsg)
            return false
        }
        return true
    }

    @objc func tapDoneDOB() {
        if let datePicker = self.txtDOB.inputView as? UIDatePicker {
            var date = Date()
            date = datePicker.date
            if date.is18Plus() {
                self.txtDOB.text = date.getFormattedDate(format: "dd-MM-yy")
            } else {
                self.txtDOB.text = nil
                let errorMessage = "Employee must be 18+"
                self.alert(message: errorMessage)
            }
        }
        self.txtDOB.resignFirstResponder()
    }

    @objc func tabDoneJoining() {
        if let datePicker = self.txtDateOfJoining.inputView as? UIDatePicker {
            var date = Date()
            date = datePicker.date
            self.txtDateOfJoining.text = date.getFormattedDate(format: "dd-MM-yy")
        }
        self.txtDateOfJoining.resignFirstResponder()
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        if txtDepartment.text == "" {
            self.departmentpicker.selectRow(0, inComponent: 0, animated: true)
            self.txtDepartment.text = self.departmentdata.self[0]
        }
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        if checkValidation() {
            print("Registered Successfully")
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
        dropDown.image = UIImage(named: "arrow_up")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        dropDown.image = UIImage(named: "arrow_down")
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
