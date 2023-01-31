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
    weak var btnProfile: UIButton?
    weak var viewController: UIViewController?
    
    //MARK: Initialization
    init(containerView: UIView, homeView: UIView, employeeView: UIView, profileView: UIView, tabbarView: UIView, btnHome: UIButton, btnEmployee: UIButton, btnProfile: UIButton, viewController: UIViewController) {
        self.containerView = containerView
        self.homeView = homeView
        self.employeeView = employeeView
        self.profileView = profileView
        self.tabbarView = tabbarView
        self.btnHome = btnHome
        self.btnEmployee = btnEmployee
        self.btnProfile = btnProfile
        self.viewController = viewController
    }
    
    // MARK: Home Tabbar Color
    func homeColor() {
        self.homeView?.backgroundColor = UIColor.customBlue
        self.employeeView?.backgroundColor = UIColor.white
        self.profileView?.backgroundColor = UIColor.white
        self.btnHome?.tintColor = UIColor.white
        self.btnEmployee?.tintColor = UIColor.customBlue
        self.btnProfile?.tintColor = UIColor.customBlue
    }
    
    // MARK: Employee Tabbar Color
    func employeeColor() {
        self.homeView?.backgroundColor = UIColor.white
        self.employeeView?.backgroundColor = UIColor.customBlue
        self.profileView?.backgroundColor = UIColor.white
        self.btnHome?.tintColor = UIColor.customBlue
        self.btnEmployee?.tintColor = UIColor.white
        self.btnProfile?.tintColor = UIColor.customBlue
    }
    
    // MARK: Setting Tabbar Color
    func settingColor() {
        self.homeView?.backgroundColor = UIColor.white
        self.employeeView?.backgroundColor = UIColor.white
        self.profileView?.backgroundColor = UIColor.customBlue
        self.btnHome?.tintColor = UIColor.customBlue
        self.btnEmployee?.tintColor = UIColor.customBlue
        self.btnProfile?.tintColor = UIColor.white
    }
    
    // MARK: Home Tabbar
    func homeTabbar() {
        let homeVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        //        homeVC!.willMove(toParent: self)
        UIView.transition(with: containerView!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        homeVC!.willMove(toParent: viewController)
        self.containerView?.addSubview(homeVC!.view)
        self.viewController?.addChild(homeVC!)
        homeVC!.didMove(toParent: viewController)
        self.homeColor()
    }
    
    // MARK: Employee Tabbar
    func employeeTabbar() {
        let employeeVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "EmployeeVC") as? EmployeeVC
        UIView.transition(with: containerView!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        employeeVC!.willMove(toParent: viewController)
        self.containerView?.addSubview(employeeVC!.view)
        self.viewController?.addChild(employeeVC!)
        employeeVC!.didMove(toParent: viewController)
        self.employeeColor()
    }
    
    // MARK: Profile Tabbar
    func profileTabbar() {
        let settingVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as? SettingVC
        UIView.transition(with: containerView!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        settingVC!.willMove(toParent: viewController)
        self.containerView?.addSubview(settingVC!.view)
        self.viewController?.addChild(settingVC!)
        settingVC!.didMove(toParent: viewController)
        self.settingColor()
    }
    
    // MARK: Shadow
    func addsShadow() {
        self.tabbarView?.addShadow()
    }
}
