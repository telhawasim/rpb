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
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLineView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordLineView: UIView!
    
    // MARK: Variables
    var dummyEmail = "rpb@admin.com"
    var dummyPassword = "12345678"
    var isShowPassword = true
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFonts()
    }
    
    // MARK: Login Button
    @IBAction func tappedLoginButton(_ sender: Any) {
        self.goToHome()
    }
    
    @IBAction func tappedShowPassword(_ sender: Any) {
        btnShowPassword.isSelected.toggle()
        
        if isShowPassword {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true
        }
        isShowPassword = !isShowPassword
    }
}

// MARK: Functions
extension LoginVC {
    // MARK: Set Colors
    func setColors() {
        lbldescription.textColor = UIColor.black222222
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        lbldescription.font = UIFont.montserratMedium(16)
        lbldescription.textColor = UIColor.darkGray
        lblLogin.font = UIFont.montserratBold(32)
        lblEmail.font = UIFont.montserratSemiBold(16)
        lblPassword.font = UIFont.montserratSemiBold(16)
        self.setColors()
    }
    
    // MARK: Navigation
    func goToHome() {
        if validation() {
            let tabbarVC  = UIStoryboard.getVC(from: .main, TabbarVC.className)
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
    
    //MARK: Validation
    func validation() -> Bool {
        guard let email = txtEmail.text,
              let password = txtPassword.text else {
            return false
        }
        var errorMessage: String?
        
        if email.isEmpty {
            errorMessage = Localization.Login.emailEmptyError
        } else if !(email.isEmailValid()) {
            errorMessage = Localization.Login.emailValidError
        } else if email != dummyEmail {
            errorMessage = Localization.Login.emailIncorrectError
        } else if password.isEmpty {
            errorMessage = Localization.Login.passwordEmptyError
        } else if password != dummyPassword {
            errorMessage = Localization.Login.passwordIncorrectError
        } else if password.count <= 5 {
            errorMessage = Localization.Login.passwordLengthError
        }
        if let errorMsg = errorMessage {
            self.alert(message: errorMsg)
            return false
        }
        return true
    }
}
