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
    var dummyEmail = "rpb@admin.com"
    var dummyPassword = "12345678"
    var isShowPassword = true
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColors()
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
        lbldescription.textColor = UIColor.customBlack
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        lbldescription.font = UIFont.montserratRegular(16)
        lblLogin.font = UIFont.montserratBold(32)
        lblEmail.font = UIFont.montserratSemiBold(16)
        lblPassword.font = UIFont.montserratSemiBold(16)
    }
    
    // MARK: Configure Show Password Button
    func configureShowPassword() {
        let image = UIImage(named: "hide_password")
        let selectedImage = UIImage(named: "show_password")
        btnShowPassword.setImage(image, for: .normal)
        btnShowPassword.setImage(selectedImage, for: .selected)
        
        if btnShowPassword.state == .normal {
            txtPassword.isSecureTextEntry = true
        } else if btnShowPassword.state == .selected {
            txtPassword.isSecureTextEntry = false
        }
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
            errorMessage = "Please enter email"
        } else if !(email.isEmailValid()) {
            errorMessage = "Please enter a valid email"
        } else if email != dummyEmail {
            errorMessage = "Email entered is incorrect"
        } else if password.isEmpty {
            errorMessage = "Please enter password"
        } else if password != dummyPassword {
            errorMessage = "Password entered is incorrect"
        } else if password.count <= 5 {
            errorMessage = "Password must be 6 digits long"
        }
        if let errorMsg = errorMessage {
            self.alert(message: errorMsg)
            return false
        }
        return true
    }
}
