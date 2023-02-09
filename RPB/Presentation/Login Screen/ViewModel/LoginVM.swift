//
//  LoginVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class LoginVM {
    
    weak var binder: LoginBinder?
    private var model: SignUpResponse?
    
    init(binder: LoginBinder) {
        self.binder = binder
        self.model = SignUpResponse()
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
    
    //MARK: API CALLS
    func userSignIn() {
        
       // let bodyParams = [ParameterKeys.email: usernameTextField.text ?? "",
                    //  ParameterKeys.password: passwordTextField.text ?? ""]
        //Loader.show()
       // UserService.shared.signIn(body: bodyParams) { response in
//            Loader.dismiss()
          //  switch response{
           // case .success(let userResponse): break
//                _ = userResponse.user?.save()
//                UserManager.shared.fetchUserInfo()
//                if self.redirectToHome { RedirectionManager.shared.gotoHome()
//                }
//                else { self.dismiss(animated: true) }
//            case .failure(let error):
//                self.showMessage(Constants.Error, error.localizedDescription, onDismiss: nil)
//            }
     //   }
    }

    
    deinit {
        self.model = nil
    }
}
