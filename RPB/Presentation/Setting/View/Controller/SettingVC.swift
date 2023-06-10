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
    var binder: SettingBinder?
    var viewModel: SettingVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.binder = SettingBinder(lblSetting: self.lblSetting, lblAccount: self.lblAccount, lblEditProfile: self.lblEditProfile, lblNotification: self.lblNotification, lblAppNotification: self.lblAppNotification)
        
        self.viewModel = SettingVM(binder: self.binder!, viewController: self)
        
        self.viewModel?.main()
    }
    
    @IBAction func tappedLogOutButton(_ sender: Any) {
        self.viewModel?.goToLogin()
    }
}
