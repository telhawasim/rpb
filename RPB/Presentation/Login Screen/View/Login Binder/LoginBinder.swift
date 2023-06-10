//
//  LoginBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit

class LoginBinder: NSObject {
    
    // MARK: Variables
    weak var lblDescription: UILabel?
    weak var lblLogin: UILabel?
    weak var lblEmail: UILabel?
    weak var lblPassword: UILabel?
    weak var txtEmail: UITextField?
    weak var txtPassword: UITextField?
    weak var btnLogin: UIButton?
    weak var btnShowPassword: UIButton?
    
    var isShowPassword = true
    
    init(lblDescription: UILabel, lblLogin: UILabel, lblEmail: UILabel, lblPassword: UILabel, txtEmail: UITextField, txtPassword: UITextField, btnLogin: UIButton, btnShowPassword: UIButton) {
        self.lblDescription = lblDescription
        self.lblLogin = lblLogin
        self.lblEmail = lblEmail
        self.lblPassword = lblPassword
        self.txtEmail = txtEmail
        self.txtPassword = txtPassword
        self.btnLogin = btnLogin
        self.btnShowPassword = btnShowPassword
    }
    
    // MARK: Set Colors
    func setColors() {
        self.lblDescription?.textColor = UIColor.customBlack
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblDescription?.font = UIFont.getRegularFont()
        self.lblDescription?.textColor = UIColor.darkGray
        self.lblLogin?.font = UIFont.getBoldFont(size: 32)
        self.lblEmail?.font = UIFont.getSemiBoldFont()
        self.lblPassword?.font = UIFont.getSemiBoldFont()
        self.setColors()
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnLogin?.cornerRadius(25)
    }
    
    // MARK: Configure TextFields
    func configureTextFields() {
        self.txtEmail?.font = UIFont.getRegularFont()
        self.txtPassword?.font = UIFont.getRegularFont()
    }
    
    // MARK: Show Password
    func tappedShowPassword() {
        btnShowPassword?.isSelected.toggle()
        
        if isShowPassword {
            txtPassword?.isSecureTextEntry = false
        } else {
            txtPassword?.isSecureTextEntry = true
        }
        isShowPassword = !isShowPassword
    }
    
    // MARK: Validation
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
        } else if password.isEmpty {
            errorMessage = Localization.Login.kPasswordEmptyError
        } else if password.count <= 5 {
            errorMessage = Localization.Login.kPasswordLengthError
        }
        
        if let errorMsg = errorMessage {
            AlertHandler.shared.alert(message: errorMsg)
            return false
        }
        return true
    }
}
