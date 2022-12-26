//
//  SettingVC.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import UIKit

class SettingVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblAppNotification: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColors()
    }
}

extension SettingVC{

    //MARK: Set Colors
    func setColors(){
        lblSetting.textColor = UIColor.customBlack
        lblAccount.textColor = UIColor.customBlack
        lblEditProfile.textColor = UIColor.customBlack
        lblNotification.textColor = UIColor.customBlack
        lblAppNotification.textColor = UIColor.customBlack
        self.configureFonts()
    }
    
    //MARK: Configure Fonts
    func configureFonts() {
        self.lblAppNotification.font = UIFont.MontserratMedium(16)
        self.lblSetting.font = UIFont.MontserratMedium(24)
        self.lblEditProfile.font = UIFont.MontserratMedium(16)
        self.lblAccount.font = UIFont.MontserratSemiBold(20)
        self.lblNotification.font = UIFont.MontserratSemiBold(20)
    }
}
