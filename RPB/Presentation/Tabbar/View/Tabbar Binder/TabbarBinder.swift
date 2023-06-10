//
//  TabbarBinder.swift
//  RPB
//
//  Created by Bilal Nisar on 31/01/2023.
//

import Foundation

class TabbarBinder: NSObject {
    
    //MARK: IBOutlets
    weak var containerView: UIView?
    weak var homeView: UIView?
    weak var employeeView: UIView?
    weak var profileView: UIView?
    weak var tabbarView: UIView?
    weak var btnHome: UIButton?
    weak var btnEmployee: UIButton?
    weak var btnLogout: UIButton?
    
    //MARK: Initialization
    init(containerView: UIView, homeView: UIView, employeeView: UIView, profileView: UIView, tabbarView: UIView, btnHome: UIButton, btnEmployee: UIButton, btnLogout: UIButton) {
        self.containerView = containerView
        self.homeView = homeView
        self.employeeView = employeeView
        self.profileView = profileView
        self.tabbarView = tabbarView
        self.btnHome = btnHome
        self.btnEmployee = btnEmployee
        self.btnLogout = btnLogout
    }
    
    // MARK: Home Tabbar Color
    func homeColor() {
        self.homeView?.backgroundColor = UIColor.appColor
        self.employeeView?.backgroundColor = UIColor.white
        self.profileView?.backgroundColor = UIColor.white
        self.btnHome?.tintColor = UIColor.white
        self.btnEmployee?.tintColor = UIColor.appColor
        self.btnLogout?.tintColor = UIColor.appColor
    }
    
    // MARK: Employee Tabbar Color
    func employeeColor() {
        self.homeView?.backgroundColor = UIColor.white
        self.employeeView?.backgroundColor = UIColor.appColor
        self.profileView?.backgroundColor = UIColor.white
        self.btnHome?.tintColor = UIColor.appColor
        self.btnEmployee?.tintColor = UIColor.white
        self.btnLogout?.tintColor = UIColor.appColor
    }
    
    // MARK: Setting Tabbar Color
    func logoutColor() {
        self.homeView?.backgroundColor = UIColor.white
        self.employeeView?.backgroundColor = UIColor.white
        self.profileView?.backgroundColor = UIColor.appColor
        self.btnHome?.tintColor = UIColor.appColor
        self.btnEmployee?.tintColor = UIColor.appColor
        self.btnLogout?.tintColor = UIColor.white
    }

    // MARK: Shadow
    func addsShadow() {
        self.tabbarView?.addShadow()
    }
}
