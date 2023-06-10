//
//  ProfilePopUpViewController.swift
//  RPB
//
//  Created by Telha Wasim on 15/02/2023.
//

import UIKit

typealias PopupViewProfileCompletionHandler = (_ value: Any?, _ textFieldValue: String?) -> Void

class ProfilePopUpViewController: BaseVC {
    
    //MARK: Outlet
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var txtProfileName: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK: Variables
    var completionHandler: PopupViewProfileCompletionHandler?
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureFonts()
        self.configureButton()
        self.configureButtonValidation(isEnabled: false)
        txtProfileName.addTarget(self, action: #selector(checkButtonValidation), for: .editingChanged)
        self.txtProfileName.delegate = self
    }
    
    func configureView() {
        self.popUpView.cornerRadius(10)
    }
    
    func configureFonts() {
        self.lblDescription.font = UIFont.getRegularFont14()
        self.lblProfileName.font = UIFont.getSemiBoldFont()
        self.txtProfileName.font = UIFont.getRegularFont()
    }
    
    func configureButton() {
        self.btnDone.cornerRadius(25)
        self.btnDone.backgroundColor = UIColor.appColor
        self.btnDone.titleLabel?.font = UIFont.getMediumFont()
        self.btnDone.tintColor = UIColor.white
    }
    
    func configureButtonValidation(isEnabled: Bool) {
        btnDone.isUserInteractionEnabled = isEnabled
        btnDone.backgroundColor = isEnabled ? UIColor.appColor : UIColor.lightGray
    }
    
    @objc func checkButtonValidation() {
        if let text = txtProfileName.text, !text.isEmpty {
            configureButtonValidation(isEnabled: true)
        } else {
            configureButtonValidation(isEnabled: false)
        }
    }
    
    //MARK: IBACTION
    @IBAction func goBackPressed(_ sender: Any) {
        dismissVC(completion: nil)
        if completionHandler != nil {
            completionHandler!(nil, "")
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismissVC(completion: nil)
        if completionHandler != nil {
            completionHandler!(sender, txtProfileName.text)
        }
    }
}

//MARK: TextField Methods
extension ProfilePopUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 50
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength
    }
}
