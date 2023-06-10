//
//  ViewController.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import UIKit

class LoginVC: BaseVC {
    
    // MARK: IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnShowPassword: UIButton!
    
    // MARK: Variables
    var binder: LoginBinder?
    var viewModel: LoginVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.binder = LoginBinder(lblDescription: self.lbldescription, lblLogin: self.lblLogin, lblEmail: self.lblEmail, lblPassword: self.lblPassword, txtEmail: self.txtEmail, txtPassword: self.txtPassword, btnLogin: self.btnLogin, btnShowPassword: self.btnShowPassword)
        
        self.viewModel = LoginVM(binder: self.binder!, viewController: self)
        
        self.viewModel?.main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.resetTextFields()
    }
    
    // MARK: Login Button
    @IBAction func tappedLoginButton(_ sender: Any) {
        self.viewModel?.userSignIn()
    }
    
    // MARK: Show Password
    @IBAction func tappedShowPassword(_ sender: Any) {
        self.viewModel?.showPassword()
    }
}
