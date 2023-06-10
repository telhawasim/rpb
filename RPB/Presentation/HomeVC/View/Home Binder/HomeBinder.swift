//
//  HomeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit
import SkeletonView

class HomeBinder: NSObject {
    
    //MARK: Variables
    weak var tableView: UITableView?
    weak var lblEmployeeCount: UILabel?
    weak var lblTotalEmployee: UILabel?
    weak var lblName: UILabel?
    weak var lblEmployee: UILabel?
    
    init(tableView: UITableView, lblEmployeeCount: UILabel, lblTotalEmployee: UILabel, lblName: UILabel, lblEmployee: UILabel) {
        self.tableView = tableView
        self.lblEmployeeCount = lblEmployeeCount
        self.lblTotalEmployee = lblTotalEmployee
        self.lblName = lblName
        self.lblEmployee = lblEmployee
    }
    
    var model: HomeModel?
    var employeeListing: EmployeeListingResponse?
    var startValue: Int = 0
    var endValue: Int?
    var didTapProfileAt: ((String) -> Void)?
    
    // MARK: Set Colors
    func setColors() {
        self.lblName?.textColor = UIColor.customBlack
        self.lblEmployee?.textColor = UIColor.customBlack
    }
    
    // MARK: Set Fonts
    func configureFonts() {
        self.lblName?.font = UIFont.getMediumFont(size: 36)
        self.lblEmployee?.font = UIFont.getMediumFont(size: 25)
        self.lblEmployeeCount?.font = UIFont.getBoldFont(size: 40)
        self.lblTotalEmployee?.font = UIFont.getMediumFont(size: 12)
        self.setColors()
    }
    
    //MARK: TableView Configuration
    func configTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(EmployeesTableViewCell.className)
        self.tableView?.register(EmptyTVCell.className)
    }
    
    //MARK: For Total number of Employees animation
    func incrementedValue() {
        DispatchQueue.main.async { [self] in
            if endValue != 0 {
                startValue += 1
                
                lblEmployeeCount?.text = "\(startValue)"
                if startValue >= endValue ?? 0 {
                    startValue = 0
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
                    self.incrementedValue()
                }
            }
        }
    }
}

//MARK: TableView Methods
extension HomeBinder: UITableViewDelegate, UITableViewDataSource {
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if employeeListing?.data?.employees == nil {
            return 5
        } else if employeeListing?.data?.employees?.count == 0 {
            return 1
        } else {
            return employeeListing?.data?.employees?.count ?? 0
        }
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if employeeListing?.data?.employees?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
            cell.setup(type: .employeeListing)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as! EmployeesTableViewCell
            if employeeListing?.data?.employees?.count != nil {
                cell.hideSkeletonForViews(tableView: self.tableView!)
                if let data = employeeListing?.data?.employees {
                    cell.configure(data: data[indexPath.row])
                }
            } else {
                cell.showSkeletonForViews(tableView: self.tableView!)
            }
            return cell
        }
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = employeeListing?.data?.employees, !data.isEmpty {
            self.didTapProfileAt?(employeeListing?.data?.employees?[indexPath.row]._id ?? "")
        }
    }
}
