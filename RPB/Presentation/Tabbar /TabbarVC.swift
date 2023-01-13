//
//  TabbarVC.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import UIKit

class TabbarVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var employeeView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var tabbarView: UIView!
    
    // MARK: Variables
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnHome.tintColor = UIColor.white
        self.homeView.backgroundColor = UIColor.customBlue
        self.tabbarView.addShadow()
        self.view.layoutIfNeeded()
        self.homeTabbar()
    }
    
    @IBAction func tappedHomeButton(_ sender: Any) {
        self.homeTabbar()
    }
    
    @IBAction func tappedEmplooyesButton(_ sender: Any) {
        self.employeeTabbar()
    }
    
    @IBAction func taappedProfile(_ sender: Any) {
        self.profileTabbar()
    }
}

// MARK: Functions
extension TabbarVC {
    // MARK: Home Tabbar
    func homeTabbar() {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
            //        homeVC!.willMove(toParent: self)
            UIView.transition(with: containerView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            homeVC!.willMove(toParent: self)
            self.containerView.addSubview(homeVC!.view)
            self.addChild(homeVC!)
            homeVC!.didMove(toParent: self)
            self.homeColor()
    }
    
    // MARK: Employee Tabbar
    func employeeTabbar() {
        let employeeVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeVC") as? EmployeeVC
        
        UIView.transition(with: containerView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        employeeVC!.willMove(toParent: self)
        self.containerView.addSubview(employeeVC!.view)
        self.addChild(employeeVC!)
        employeeVC!.didMove(toParent: self)
        self.employeeColor()
        
    }
    
    // MARK: Profile Tabbar
    func profileTabbar() {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as? SettingVC
        
        UIView.transition(with: containerView, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        settingVC!.willMove(toParent: self)
        self.containerView.addSubview(settingVC!.view)
        self.addChild(settingVC!)
        settingVC!.didMove(toParent: self)
        self.settingColor()
        
    }
    
    // MARK: Home Tabbar Color
    func homeColor() {
        self.homeView.backgroundColor = UIColor.customBlue
        self.employeeView.backgroundColor = UIColor.white
        self.profileView.backgroundColor = UIColor.white
        self.btnHome.tintColor = UIColor.white
        self.btnEmployee.tintColor = UIColor.customBlue
        self.btnProfile.tintColor = UIColor.customBlue
    }
    
    // MARK: Employee Tabbar Color
    func employeeColor() {
        self.homeView.backgroundColor = UIColor.white
        self.employeeView.backgroundColor = UIColor.customBlue
        self.profileView.backgroundColor = UIColor.white
        self.btnHome.tintColor = UIColor.customBlue
        self.btnEmployee.tintColor = UIColor.white
        self.btnProfile.tintColor = UIColor.customBlue
    }
    
    // MARK: Setting Tabbar Color
    func settingColor() {
        self.homeView.backgroundColor = UIColor.white
        self.employeeView.backgroundColor = UIColor.white
        self.profileView.backgroundColor = UIColor.customBlue
        self.btnHome.tintColor = UIColor.customBlue
        self.btnEmployee.tintColor = UIColor.customBlue
        self.btnProfile.tintColor = UIColor.white
    }
}
