//
//  EmployeeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit

class EmployeeBinder: NSObject {
    
    weak var tableView: UITableView?
    weak var lblEmployee: UILabel?
    weak var txtSearch: UITextField?
    weak var viewController: UIViewController?
    
    init(tableView: UITableView, lblEmployee: UILabel?, txtSearch: UITextField, viewController: UIViewController) {
        self.tableView = tableView
        self.lblEmployee = lblEmployee
        self.txtSearch = txtSearch
        self.viewController = viewController
    }
    
    // MARK: Colors
    func setColors() {
        self.lblEmployee?.textColor = UIColor.customBlack
    }
    
    // MARK: Fonts
    func configureFonts() {
        self.lblEmployee?.font = UIFont.getMediumFont(size: 24)
    }
    
    // MARK: Configure TextField
    func configureTextField() {
        self.txtSearch?.attributedPlaceholder = NSAttributedString(string: Localization.Employee.kSearch, attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlack, NSAttributedString.Key.font: UIFont.getMediumFont(size: 14)])
    }
    
    // MARK: Register Cell
    func registerCell() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(EmployeesTableViewCell.className)
    }
    
    // MARK: TableView Animation
    func tableViewAnimation() {
        self.tableView?.reloadWithAnimation()
    }
    
    // MARK: Go to Employee VC
    func goToAddEmployee() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, AddEmployeeVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}

extension EmployeeBinder: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as! EmployeesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabbarVC = UIStoryboard.getVC(from: .main, ProfileVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}
