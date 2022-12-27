//
//  SettingVC.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import UIKit

class SettingVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblAppNotification: UILabel!

    // MARK: Variables

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColors()
    }
}

extension SettingVC {

    // MARK: Set Colors
    func setColors() {
        lblSetting.textColor = UIColor.customBlack
        lblAccount.textColor = UIColor.customBlack
        lblEditProfile.textColor = UIColor.customBlack
        lblNotification.textColor = UIColor.customBlack
        lblAppNotification.textColor = UIColor.customBlack
        self.configureFonts()
    }

    // MARK: Configure Fonts
    func configureFonts() {
        self.lblAppNotification.font = UIFont.montserratMedium(14)
        self.lblSetting.font = UIFont.montserratMedium(22)
        self.lblEditProfile.font = UIFont.montserratMedium(14)
        self.lblAccount.font = UIFont.montserratRegular(18)
        self.lblNotification.font = UIFont.montserratRegular(18)
    }
}
