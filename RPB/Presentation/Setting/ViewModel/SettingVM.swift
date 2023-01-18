//
//  SettingVM.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

class SettingVM {
    
    weak var binder: SettingBinder?
    private var model: SettingModel?
    
    init(binder: SettingBinder) {
        self.binder = binder
        self.model = SettingModel()
    }
    
    func main() {
        self.binder?.setColors()
    }
    
    func goToLogin() {
        self.binder?.goToLoginVC()
    }
}
