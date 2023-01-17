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
    
    @IBAction func tappedLogOutButton(_ sender: Any) {
        self.goToLoginVC()
    }
}

extension SettingVC {
    
    //MARK: Go to Login Screen
    func goToLoginVC() {
        let loginVC  = UIStoryboard.getVC(from: .main, LoginVC.className)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
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
        self.lblAppNotification.font = UIFont.getMediumFont(size: 14)
        self.lblSetting.font = UIFont.getMediumFont(size: 24)
        self.lblEditProfile.font = UIFont.getMediumFont(size: 14)
        self.lblAccount.font = UIFont.getRegularFont(size: 18)
        self.lblNotification.font = UIFont.getRegularFont(size: 18)
    }
}
