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
        
        self.binder = HomeBinder(tableView: tableView, lblEmployeeCount: lblEmployeeCount, lblTotalEmployee: lblTotalEmployee, lblName: lblName, lblEmployee: lblEmployee, viewController: self)
        
        self.viewModel = HomeVM(binder: self.binder!)
        
        self.viewModel?.main()
    }

    // MARK: Add Employee
    @IBAction func btnAddEmployee(_ sender: Any) {
        self.viewModel?.addEmpployeeButton()
    }
}
