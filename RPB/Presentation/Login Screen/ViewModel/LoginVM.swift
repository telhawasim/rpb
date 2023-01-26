//
//  LoginVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class LoginVM {
    
    weak var binder: LoginBinder?
    private var model: LoginModel?
    
    init(binder: LoginBinder) {
        self.binder = binder
        self.model = LoginModel()
    }
    
    func main() {
        binder?.configureFonts()
    }
    
    func showPassword() {
        binder?.tappedShowPassword()
    }
    
    func goToMain() {
        binder?.goToMain()
    }
    
    deinit {
        self.model = nil
    }
}
