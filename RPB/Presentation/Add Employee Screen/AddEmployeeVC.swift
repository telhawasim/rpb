//
//  AddEmployeeVC.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import UIKit

class AddEmployeeVC: UIViewController {
    
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
        self.profileImage.isCircular()
    }
    
    //MARK: Configure Picker for Department
    func configurePicker() {
        self.department_picker.delegate = self
        self.txtDepartment.inputView = department_picker
        self.txtDOB.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    //MARK: Configure Add Button
    func configureAddButton() {
        self.btnAdd.cornerRadius(30)
        self.btnAdd.backgroundColor = UIColor.customBlue
        self.btnAdd.setTitleColor(UIColor.white, for: .normal)
        self.btnAdd.setTitle("Add", for: .normal)
    }
    
    @objc func tapDone() {
        if let datePicker = self.txtDOB.inputView as? UIDatePicker {
            var date = Date()
            date = datePicker.date
            self.txtDOB.text = date.getFormattedDate(format: "dd-MM-yy")
        }
        self.txtDOB.resignFirstResponder()
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
    }
}
