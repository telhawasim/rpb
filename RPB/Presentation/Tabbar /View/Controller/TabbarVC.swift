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
    var tabbarbinder: TabbarBinder?
    var viewModel: TabbarVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabbarbinder =  TabbarBinder(containerView: self.containerView, homeView: self.homeView, employeeView: self.employeeView, profileView: self.profileView, tabbarView: self.tabbarView, btnHome: self.btnHome, btnEmployee: self.btnEmployee, btnProfile: self.btnProfile, viewController: self)
        
        self.viewModel =  TabbarVM(binder: self.tabbarbinder!)
        self.viewModel?.main()
        self.tabbarbinder?.homeColor()
        self.view.layoutIfNeeded()
        self.tabbarbinder?.homeTabbar()
    }
    
    @IBAction func tappedHomeButton(_ sender: Any) {
        self.tabbarbinder?.homeTabbar()
    }
    
    @IBAction func tappedEmplooyesButton(_ sender: Any) {
        self.tabbarbinder?.employeeTabbar()
    }
    
    @IBAction func taappedProfile(_ sender: Any) {
        self.tabbarbinder?.profileTabbar()
    }
}
