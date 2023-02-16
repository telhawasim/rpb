//
//  AddEmployeeVC.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import UIKit

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
    @IBOutlet weak var departmentIcon: UIImageView!
    @IBOutlet weak var designationIcon: UIImageView!
    @IBOutlet weak var dobIcon: UIImageView!
    @IBOutlet weak var dateOfJoiningIcon: UIImageView!
    
    // MARK: Variables
    var binder: AddEmployeeBinder?
    var viewModel: AddEmployeeVM?
    
    // MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binder = AddEmployeeBinder(lblTitle: self.lblTitle, profileImage: self.profileImage, lblName: self.lblName, lblDesignation: self.lblDesignation, lblDepartment: self.lblDepartment, lblDOB: self.lblDOB, lblEmail: self.lblEmail, lblPhone: self.lblPhone, lblDateOfJoining: self.lblDateOfJoining, btnAdd: self.btnAdd, txtName: self.txtName, txtDesignation: self.txtDesignation, txtDOB: self.txtDOB, txtEmail: self.txtEmail, txtPhone: self.txtPhone, txtDepartment: self.txtDepartment, txtDateOfJoining: self.txtDateOfJoining, designationIcon: self.designationIcon, departmentIcon: self.departmentIcon, dobIcon: self.dobIcon, dateOfJoiningIcon: self.dateOfJoiningIcon, viewController: self)
        
        viewModel = AddEmployeeVM(binder: self.binder!)
        
        viewModel?.main()
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        viewModel?.addEmployeeInformation()
    }
    
    @IBAction func addBtnImage(_ sender: Any) {
        viewModel?.addImage()
    }
    
    @IBAction func tappedShowPopUp(_ sender: Any) {
        viewModel?.showPopUp()
    }
}
