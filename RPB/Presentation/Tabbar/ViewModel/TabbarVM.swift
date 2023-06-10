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
    weak var viewController: UIViewController?
    
    //MARK: Init
    init(binder: TabbarBinder, viewController: UIViewController) {
        self.tabbarBinder = binder
        self.viewController = viewController
    }
    
    func main() {
        tabbarBinder?.homeColor()
        tabbarBinder?.employeeColor()
        tabbarBinder?.logoutColor()
        tabbarBinder?.addsShadow()
    }
    
    func navigateToScreen(screen: TabbarType) {
        switch screen {
        case .home:
            let homeVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
            homeVC!.willMove(toParent: viewController)
            UIView.transition(with: (tabbarBinder?.containerView)!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            homeVC!.willMove(toParent: viewController)
            self.tabbarBinder?.containerView?.addSubview(homeVC!.view)
            self.viewController?.addChild(homeVC!)
            homeVC!.didMove(toParent: viewController)
            self.tabbarBinder?.homeColor()
        case .employees:
            let employeeVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "EmployeeVC") as? EmployeeVC
            UIView.transition(with: (tabbarBinder?.containerView)!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            employeeVC!.willMove(toParent: viewController)
            self.tabbarBinder?.containerView?.addSubview(employeeVC!.view)
            self.viewController?.addChild(employeeVC!)
            employeeVC!.didMove(toParent: viewController)
            self.tabbarBinder?.employeeColor()
        case .logout:
            UIView.transition(with: (tabbarBinder?.containerView)!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            User.remove()
            _ = UIStoryboard.getVC(from: .main, LoginVC.className)
            self.viewController?.navigationController?.popToRootViewController(animated: true)
            self.tabbarBinder?.logoutColor()
        }
    }
}
