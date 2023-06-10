//
//  LoginVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class LoginVM {
    
    // MARK: Variables
    weak var binder: LoginBinder?
    var viewController: UIViewController?
    
    init(binder: LoginBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
    }
    
    // MARK: Main Function
    func main() {
        binder?.configureFonts()
        binder?.configureButtons()
        binder?.configureTextFields()
    }
    
    // MARK: Reset textFields Data
    func resetTextFields() {
        binder?.txtEmail?.text = Constants.email
        binder?.txtPassword?.text = Constants.password
        binder?.txtPassword?.isSecureTextEntry = true
        binder?.isShowPassword = true
        binder?.btnShowPassword?.isSelected = false
    }
    
    // MARK: Show Password
    func showPassword() {
        binder?.tappedShowPassword()
    }
    
    //MARK: API CALLS
    func userSignIn() {
        guard let validation = binder?.validation(), validation else { return }
        
        let bodyParams = [ParameterKeys.email: binder?.txtEmail?.text ?? "",
                          ParameterKeys.password: binder?.txtPassword?.text ?? ""]
        DispatchQueue.main.async {
            Loader.start()
        }
        UserService.shared.signIn(body: bodyParams) { response in
            DispatchQueue.main.async {
                Loader.stop()
                switch response {
                case .success(let userResponse):
                    _ = userResponse.data?.save()
                    let tabbarVC = UIStoryboard.getVC(from: .main, TabbarVC.className)
                    self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
}
