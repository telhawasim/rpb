//
//  LoginBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit

class LoginBinder: NSObject {
    
    //MARK: Variables
    weak var lblDescription: UILabel?
    weak var lblLogin: UILabel?
    weak var lblEmail: UILabel?
    weak var lblPassword: UILabel?
    weak var txtEmail: UITextField?
    weak var txtPassword: UITextField?
    weak var btnLogin: UIButton?
    weak var btnShowPassword: UIButton?
    weak var viewController: UIViewController?
    
    var dummyEmail = "rpb@admin.com"
    var dummyPassword = "12345678"
    var isShowPassword = true
    
    init(lblDescription: UILabel, lblLogin: UILabel, lblEmail: UILabel, lblPassword: UILabel, txtEmail: UITextField, txtPassword: UITextField, btnLogin: UIButton, btnShowPassword: UIButton, viewController: UIViewController) {
        self.lblDescription = lblDescription
        self.lblLogin = lblLogin
        self.lblEmail = lblEmail
        self.lblPassword = lblPassword
        self.txtEmail = txtEmail
        self.txtPassword = txtPassword
        self.btnLogin = btnLogin
        self.btnShowPassword = btnShowPassword
        self.viewController = viewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set Colors
    func setColors() {
        lblDescription?.textColor = UIColor.customBlack
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        lblDescription?.font = UIFont.getMediumFont(size: 16)
        lblDescription?.textColor = UIColor.darkGray
        lblLogin?.font = UIFont.getBoldFont(size: 32)
        lblEmail?.font = UIFont.getSemiBoldFont()
        lblPassword?.font = UIFont.getSemiBoldFont()
        self.setColors()
    }
    
    func tappedShowPassword() {
        btnShowPassword?.isSelected.toggle()
        
        if isShowPassword {
            txtPassword?.isSecureTextEntry = false
        } else {
            txtPassword?.isSecureTextEntry = true
        }
        isShowPassword = !isShowPassword
    }
    
    //MARK: Validation
    func validation() -> Bool {
        guard let email = txtEmail?.text,
              let password = txtPassword?.text else {
            return false
        }
        var errorMessage: String?
        
        if email.isEmpty {
            errorMessage = Localization.Login.kEmailEmptyError
        } else if !(email.isEmailValid()) {
            errorMessage = Localization.Login.kEmailInvalidError
        } else if email != dummyEmail {
            errorMessage = Localization.Login.kEmailIncorrectError
        } else if password.isEmpty {
            errorMessage = Localization.Login.kPasswordEmptyError
        } else if password.count <= 5 {
            errorMessage = Localization.Login.kPasswordLengthError
        } else if password != dummyPassword {
            errorMessage = Localization.Login.kPasswordIncorrectError
        }
        
        if let errorMsg = errorMessage {
            AlertHandler.shared.alert(message: errorMsg)
            return false
        }
        return true
    }
    
    func goToMain() {
        if validation() {
            let tabbarVC  = UIStoryboard.getVC(from: .main, TabbarVC.className)
            viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
}
