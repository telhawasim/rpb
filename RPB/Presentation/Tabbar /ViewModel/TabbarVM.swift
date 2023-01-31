//
//  TabbarVM.swift
//  RPB
//
//  Created by Bilal Nisar on 31/01/2023.
//

import Foundation

class TabbarVM {
    
    //MARK: IBOutlets
    
    //MARK: Variables
    weak var tabbarBinder: TabbarBinder?
    
    //MARK: Init
    init(binder: TabbarBinder) {
        self.tabbarBinder = binder
    }
    
    func main() {
        tabbarBinder?.homeColor()
        tabbarBinder?.employeeColor()
        tabbarBinder?.settingColor()
        tabbarBinder?.addsShadow()
    }
    
    func homeTabbarButton() {
        tabbarBinder?.homeTabbar()
    }
    
    func employeeTabbarButton() {
        tabbarBinder?.employeeTabbar()
    }
    
    func settingTabbarButton() {
        tabbarBinder?.profileTabbar()
    }
    
}
