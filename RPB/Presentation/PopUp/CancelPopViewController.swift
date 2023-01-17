//
//  CancelPopViewController.swift
//  RPB
//
//  Created by Bilal Nisar on 28/12/2022.
//

import UIKit

enum PopupType {
    case discardInformation
    case deleteProfile
}

typealias PopupViewCompletionHandler = (_ value: Any?) -> Void

class CancelPopViewController: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    //MARK: Variables
    var completionHandler: PopupViewCompletionHandler?
    var popupType: PopupType?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureFont()
        self.configureButtons()
        self.setupUI()
    }
    
    //MARK: Configure Views
    func configureView() {
        self.popUpView.cornerRadius(10)
    }
    
    //MARK: Configure Fonts
    func configureFont() {
        self.lblTitle.font = UIFont.getCustomFont_Medium(size: 32)
        self.lblDescription.font = UIFont.getCustomFont_Medium(size: 14)
        self.btnYes.titleLabel?.font = UIFont.getDefaultFont_Medium()
        self.btnNo.titleLabel?.font = UIFont.getDefaultFont_Medium()
    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnYes.backgroundColor = UIColor.customBlue
        self.btnNo.borderWidth = 1
        self.btnNo.borderColor = UIColor.customBlue
        self.btnYes.tintColor = UIColor.white
        self.btnNo.tintColor = UIColor.customBlue
    }
    
    //MARK: SetupUI 
    func setupUI() {
        switch popupType {
        case .discardInformation:
            lblTitle.text = "Are You Sure?"
            lblDescription.text = "You want to discard this information."
        case .deleteProfile:
            lblTitle.text = "Are You Sure?"
            lblDescription.text = "You want to delete this Profile."
        default:
            print("Error")
        }
    }
    
    //MARK: IBACTIONS
    @IBAction func tappedCancelButton(_ sender: Any) {
        dismissVC(completion: nil)
        if completionHandler != nil {
            completionHandler!(nil)
        }
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        dismissVC(completion: nil)
        if completionHandler != nil {
            completionHandler!(nil)
        }
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        dismissVC(completion: nil)
            if completionHandler != nil {
                completionHandler!(sender)
            }
    }
}
