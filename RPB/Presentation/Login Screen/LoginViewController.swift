//
//  ViewController.swift
//  RPB
//
//  Created by Bilal Nisar on 20/12/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblLogin: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColors()
        self.configureFonts()
    }
    
    //MARK: Set Colors
    func setColors(){
        lbldescription.textColor = UIColor.customBlack
    }
    
    //MARK: Set Colors
    func configureFonts(){
        lbldescription.font = UIFont.MontserratRegular(16)
        lblLogin.font = UIFont.MontserratBold(32)
    }
    
    //MARK: Login Button
    @IBAction func tappedLoginButton(_ sender: Any) {
        
    }
}

