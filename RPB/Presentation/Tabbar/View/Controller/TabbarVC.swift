//
//  TabbarVC.swift
//  RPB
//
//  Created by Bilal Nisar on 23/12/2022.
//

import UIKit

class TabbarVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var employeeView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var tabbarView: UIView!
    
    // MARK: Variables
    var tabbarbinder: TabbarBinder?
    var viewModel: TabbarVM?
    var isNavigationEmployee: Bool = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabbarbinder =  TabbarBinder(containerView: self.containerView, homeView: self.homeView, employeeView: self.employeeView, profileView: self.profileView, tabbarView: self.tabbarView, btnHome: self.btnHome, btnEmployee: self.btnEmployee, btnLogout: self.btnLogout)
        
        self.viewModel =  TabbarVM(binder: self.tabbarbinder!, viewController: self)
        self.viewModel?.main()
        self.view.layoutIfNeeded()
        if isNavigationEmployee {
            self.viewModel?.navigateToScreen(screen: .employees)
        } else {
            self.viewModel?.navigateToScreen(screen: .home)
        }
    }
    
    @IBAction func tappedHomeButton(_ sender: Any) {
        self.viewModel?.navigateToScreen(screen: .home)
    }
    
    @IBAction func tappedEmplooyesButton(_ sender: Any) {
        self.viewModel?.navigateToScreen(screen: .employees)
    }
    
    @IBAction func taappedLogout(_ sender: Any) {
        self.viewModel?.navigateToScreen(screen: .logout)
    }
}
