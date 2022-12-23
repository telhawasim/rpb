//
//  ProfileVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnAddCV: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblProfiles: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    //MARK: Variables
    
    //MARK: Lifecylce

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButtons()
        self.configureFonts()
    }
    
    //MARK: Configure Buttons
    func configureButtons() {
        self.btnback.isCircular()
        self.btnAddCV.isCircular()
    }
    
    //MARK: Configure Fonts
    func configureFonts() {
        self.lblName.font = UIFont.MontserratBold(20)
        self.lblDesignation.font = UIFont.MontserratMedium(14)
        self.lblEmail.font = UIFont.MontserratRegular(16)
        self.lblProfiles.font = UIFont.MontserratSemiBold(24)
    }
}
