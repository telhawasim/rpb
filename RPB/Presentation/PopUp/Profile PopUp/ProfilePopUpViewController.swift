//
//  ProfilePopUpViewController.swift
//  RPB
//
//  Created by Telha Wasim on 15/02/2023.
//

import UIKit


class ProfilePopUpViewController: BaseVC {
    
    //MARK: Outlet
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var txtProfileName: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK: Variables
    var completionHandler: PopupViewCompletionHandler?

    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureFonts()
        self.configureButton()
        self.configureButtonValidation(isEnabled: false)
        txtProfileName.addTarget(self, action: #selector(checkButtonValidation), for: .editingChanged)
    }
    
    func configureView() {
        self.popUpView.cornerRadius(10)
    }
    
    func configureFonts() {
        self.lblDescription.font = UIFont.getMediumFont14()
        self.lblProfileName.font = UIFont.getSemiBoldFont()
        self.txtProfileName.font = UIFont.getMediumFont()
    }
    
    func configureButton() {
        self.btnDone.cornerRadius(25)
        self.btnDone.backgroundColor = UIColor.customBlue
        self.btnDone.titleLabel?.font = UIFont.getMediumFont()
        self.btnDone.tintColor = UIColor.white
    }
    
    func configureButtonValidation(isEnabled: Bool) {
        btnDone.isUserInteractionEnabled = isEnabled
        btnDone.backgroundColor = isEnabled ? UIColor.customBlue : UIColor.lightGray
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
            completionHandler!(nil)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismissVC(completion: nil)
        if completionHandler != nil {
            completionHandler!(sender)
        }
    }
}
