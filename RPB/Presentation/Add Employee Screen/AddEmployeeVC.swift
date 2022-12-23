//
//  AddEmployeeVC.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import UIKit

class AddEmployeeVC: BaseVC {
    
    //MARK: Outlet
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
    
    //MARK: Variables
    let department_picker = UIPickerView()
    let department_data = [String](arrayLiteral: "", "Development", "Testing", "Creative", "Management")
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFont()
        self.configureAddButton()
        self.configureProfilePciture()
        self.configurePicker()
        self.configureTextField()
    }
    
    //MARK: Configure Font
    func configureFont() {
        self.lblTitle.font = UIFont.MontserratMedium(24)
        self.lblName.font = UIFont.MontserratSemiBold(16)
        self.lblDesignation.font = UIFont.MontserratSemiBold(16)
        self.lblDepartment.font = UIFont.MontserratSemiBold(16)
        self.lblDOB.font = UIFont.MontserratSemiBold(16)
        self.lblEmail.font = UIFont.MontserratSemiBold(16)
        self.lblPhone.font = UIFont.MontserratSemiBold(16)
        self.lblDateOfJoining.font = UIFont.MontserratSemiBold(16)
        self.txtName.font = UIFont.MontserratMedium(16)
        self.txtDesignation.font = UIFont.MontserratMedium(16)
        self.txtDOB.font = UIFont.MontserratMedium(16)
        self.txtEmail.font = UIFont.MontserratMedium(16)
        self.txtPhone.font = UIFont.MontserratMedium(16)
        self.txtDepartment.font = UIFont.MontserratMedium(16)
        self.txtDateOfJoining.font = UIFont.MontserratMedium(16)
    }
    
    //MARK: Configure Profile Picture
    func configureProfilePciture() {
        self.profileImage.isCircularImage()
    }
    
    //MARK: Configure Picker for Department
    func configurePicker() {
        self.department_picker.delegate = self
        self.txtDepartment.inputView = department_picker
        self.txtDOB.setInputViewDatePicker(target: self, selector: #selector(tapDoneDOB))
        self.txtDateOfJoining.setInputViewDatePicker(target: self, selector: #selector(tabDoneJoining))
    }
    
    //MARK: Configure Add Button
    func configureAddButton() {
        self.btnAdd.cornerRadius(30)
        self.btnAdd.backgroundColor = UIColor.customBlue
        self.btnAdd.setTitleColor(UIColor.white, for: .normal)
        self.btnAdd.setTitle("Add", for: .normal)
    }
    
    //MARK: Configure TextField
    func configureTextField() {
        txtDepartment.delegate = self
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
        var errorMessage : String?
        
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
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if checkValidation() {
            print("Registered Successfully")
        }
    }
    
    
}

//MARK: UIPicker Methods
extension AddEmployeeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return department_data.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return department_data[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtDepartment.text = department_data[row]
        self.view.endEditing(true)
        dropDown.image = UIImage(named: "arrow_down")
    }
}

//MARK: TextField Methods
extension AddEmployeeVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        dropDown.image = UIImage(named: "arrow_up")
    }
}
