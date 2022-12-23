//
//  ViewController.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColors()
        self.configureFonts()
    }
    
    //MARK: Login Button
    @IBAction func tappedLoginButton(_ sender: Any) {
        
    }
}

//MARK: Functions
extension LoginVC{
    //MARK: Set Colors
    func setColors(){
        lbldescription.textColor = UIColor.customBlack
    }
    
    //MARK: Configure Fonts
    func configureFonts(){
        lbldescription.font = UIFont.MontserratRegular(16)
        lblLogin.font = UIFont.MontserratBold(32)
        lblEmail.font = UIFont.MontserratSemiBold(16)
        lblPassword.font = UIFont.MontserratSemiBold(16)
    }
}

