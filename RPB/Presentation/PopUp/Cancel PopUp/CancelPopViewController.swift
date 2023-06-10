//
//  CancelPopViewController.swift
//  RPB
//
//  Created by Bilal Nisar on 28/12/2022.
//

import UIKit

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
        self.lblTitle.font = UIFont.getMediumFont(size: 32)
        self.lblDescription.font = UIFont.getRegularFont14()
        self.btnYes.titleLabel?.font = UIFont.getMediumFont()
        self.btnNo.titleLabel?.font = UIFont.getMediumFont()
    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnYes.backgroundColor = UIColor.appColor
        self.btnYes.setTitleColor(UIColor.white, for: .normal)
        self.btnYes.titleLabel?.font = UIFont.getBoldFont(size: 16)
        self.btnNo.borderWidth = 1
        self.btnNo.borderColor = UIColor.appColor
        self.btnNo.tintColor = UIColor.black
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
