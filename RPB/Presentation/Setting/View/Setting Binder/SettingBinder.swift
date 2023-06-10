//
//  SettingBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit

class SettingBinder: NSObject {
    
    weak var lblSetting: UILabel?
    weak var lblAccount: UILabel?
    weak var lblEditProfile: UILabel?
    weak var lblNotification: UILabel?
    weak var lblAppNotification: UILabel?
    
    init(lblSetting: UILabel, lblAccount: UILabel, lblEditProfile: UILabel, lblNotification: UILabel, lblAppNotification: UILabel) {
        self.lblSetting = lblSetting
        self.lblAccount = lblAccount
        self.lblEditProfile = lblEditProfile
        self.lblNotification = lblNotification
        self.lblAppNotification = lblAppNotification
    }
    
    // MARK: Set Colors
    func setColors() {
        lblSetting?.textColor = UIColor.customBlack
        lblAccount?.textColor = UIColor.customBlack
        lblEditProfile?.textColor = UIColor.customBlack
        lblNotification?.textColor = UIColor.customBlack
        lblAppNotification?.textColor = UIColor.customBlack
        self.configureFonts()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblAppNotification?.font = UIFont.getMediumFont(size: 14)
        self.lblSetting?.font = UIFont.getMediumFont(size: 24)
        self.lblEditProfile?.font = UIFont.getMediumFont(size: 14)
        self.lblAccount?.font = UIFont.getRegularFont(size: 18)
        self.lblNotification?.font = UIFont.getRegularFont(size: 18)
    }
}
