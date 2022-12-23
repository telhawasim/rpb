//
//  TabbarVC.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import UIKit

class TabbarVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var employeeView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var tabbarView: UIView!
    
    //MARK: Variables
    
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnHome.tintColor = UIColor.white
        self.homeView.backgroundColor = UIColor.customBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

//MARK: Functions
extension TabbarVC {
    //MARK: Home Tabbar
    func homeTabbar(){
        let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        HomeVC!.willMove(toParent: self)
        self.containerView.addSubview(HomeVC!.view)
        self.addChild(HomeVC!)
        HomeVC!.didMove(toParent: self)
        self.homeColor()
    }
    
    //MARK: Employee Tabbar
    func employeeTabbar(){
        let EmployeeVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeVC") as? EmployeeVC
        
        EmployeeVC!.willMove(toParent: self)
        self.containerView.addSubview(EmployeeVC!.view)
        self.addChild(EmployeeVC!)
        EmployeeVC!.didMove(toParent: self)
        self.employeeColor()
    }
    
    //MARK: Profile Tabbar
    func profileTabbar(){
        let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        ProfileVC!.willMove(toParent: self)
        self.containerView.addSubview(ProfileVC!.view)
        self.addChild(ProfileVC!)
        ProfileVC!.didMove(toParent: self)
        self.ProfileColor()
    }
    
    //MARK: Home Tabbar Color
    func homeColor(){
        self.homeView.backgroundColor = UIColor.customBlue
        self.employeeView.backgroundColor = UIColor.white
        self.profileView.backgroundColor = UIColor.white
        self.btnHome.tintColor = UIColor.white
        self.btnEmployee.tintColor = UIColor.customBlue
        self.btnProfile.tintColor = UIColor.customBlue
    }
    
    //MARK: Employee Tabbar Color
    func employeeColor(){
        self.homeView.backgroundColor = UIColor.white
        self.employeeView.backgroundColor = UIColor.customBlue
        self.profileView.backgroundColor = UIColor.white
        self.btnHome.tintColor = UIColor.customBlue
        self.btnEmployee.tintColor = UIColor.white
        self.btnProfile.tintColor = UIColor.customBlue
    }
    
    //MARK: Profile Tabbar Color
    func ProfileColor(){
        self.homeView.backgroundColor = UIColor.white
        self.employeeView.backgroundColor = UIColor.white
        self.profileView.backgroundColor = UIColor.customBlue
        self.btnHome.tintColor = UIColor.customBlue
        self.btnEmployee.tintColor = UIColor.customBlue
        self.btnProfile.tintColor = UIColor.white
    }
}
