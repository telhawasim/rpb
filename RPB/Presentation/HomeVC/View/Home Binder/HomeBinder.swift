//
//  HomeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit

class HomeBinder: NSObject {
    
    weak var tableView: UITableView?
    weak var lblEmployeeCount: UILabel?
    weak var lblTotalEmployee: UILabel?
    weak var lblName: UILabel?
    weak var lblEmployee: UILabel?
    weak var viewController: UIViewController?
    var model: HomeModel?
    
    init(tableView: UITableView, lblEmployeeCount: UILabel, lblTotalEmployee: UILabel, lblName: UILabel, lblEmployee: UILabel, viewController: UIViewController) {
        self.tableView = tableView
        self.lblEmployeeCount = lblEmployeeCount
        self.lblTotalEmployee = lblTotalEmployee
        self.lblName = lblName
        self.lblEmployee = lblEmployee
        self.viewController = viewController
    }
    
    // MARK: Set Colors
    func setColors() {
        self.lblName?.textColor = UIColor.customBlack
        self.lblEmployee?.textColor = UIColor.customBlack
    }

    // MARK: Set Fonts
    func configureFonts() {
        self.lblName?.font = UIFont.getMediumFont(size: 34)
        self.lblEmployee?.font = UIFont.getRegularFont(size: 24)
        self.lblEmployeeCount?.font = UIFont.getBoldFont(size: 40)
        self.setColors()
    }
    
    //MARK: TableView Configuration
    func configTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(EmployeesTableViewCell.className)
    }
    
    //MARK: Model Data
    func getData(model: HomeModel) {
        self.model = model
    }
    
    //MARK: Add Employee Button
    func addEmpployeeButton() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, AddEmployeeVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}

//MARK: TableView Methods
extension HomeBinder: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.number ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as! EmployeesTableViewCell
//        let product = viewModel.products[indexPath.row]
//        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ProfileVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}
