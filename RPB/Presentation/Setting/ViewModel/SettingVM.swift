//
//  SettingVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class SettingVM {
    
    weak var binder: SettingBinder?
    weak var viewController: UIViewController?
    private var model: SettingModel?
    
    init(binder: SettingBinder, viewController: UIViewController) {
        self.binder = binder
        self.viewController = viewController
        self.model = SettingModel()
    }
    
    func main() {
        self.binder?.setColors()
    }
    
    func goToLogin() {
        let loginVC  = UIStoryboard.getVC(from: .main, LoginVC.className)
        self.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
