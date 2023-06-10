//
//  HomeVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class HomeVC: BaseVC {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmployeeCount: UILabel!
    @IBOutlet weak var lblTotalEmployee: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmployee: UILabel!

    // MARK: Variables
    var binder: HomeBinder?
    var viewModel: HomeVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.binder = HomeBinder(tableView: self.tableView, lblEmployeeCount: self.lblEmployeeCount, lblTotalEmployee: self.lblTotalEmployee, lblName: self.lblName, lblEmployee: self.lblEmployee)
        
        self.viewModel = HomeVM(binder: self.binder!, viewController: self)
        
        self.viewModel?.main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.apiCall()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        binder?.employeeListing = nil
        binder?.model = nil
    }

    // MARK: Add Employee
    @IBAction func btnAddEmployee(_ sender: Any) {
        self.viewModel?.navigateAddEmployeeScreen()
    }
    
    // MARK: Navigate to All Employees
    @IBAction func viewAllEmployee(_ sender: Any) {
        self.viewModel?.navigateToEmployees()
    }
}
