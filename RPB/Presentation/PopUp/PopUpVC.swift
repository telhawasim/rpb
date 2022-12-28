//
//  PopUpVC.swift
//  RPB
//
//  Created by Telha Wasim on 28/12/2022.
//

import UIKit
import SwiftPopup

class PopUpVC: SwiftPopup {
    
    //MARK: Outlet
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!

    //MARK: Variables
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFont()
        self.configureButton()
        self.configureView()
    }
    
    func configureFont() {
        self.lblTitle.font = UIFont.montserratMedium(32)
        self.lblDescription.font = UIFont.montserratRegular(14)
        self.btnYes.titleLabel?.font = UIFont.montserratMedium(16)
        self.btnNo.titleLabel?.font = UIFont.montserratMedium(16)
    }
    
    func configureButton() {
        self.btnYes.backgroundColor = UIColor.customBlue
        self.btnYes.tintColor = UIColor.white
        self.btnNo.borderColor = UIColor.customBlue
        self.btnNo.borderWidth = 1
    }
    
    func configureView() {
        self.popUpView.cornerRadius(10)
    }
    
    @IBAction func btnCrossPressed(_ sender: Any) {
        self.dismiss()
    }
}
