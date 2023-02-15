//
//  EmployeeVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class EmployeeVC: BaseVC {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmployee: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    
    // MARK: Variables
    var binder: EmployeeBinder?
    var viewModel: EmployeeVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.binder = EmployeeBinder(tableView: self.tableView, lblEmployee: self.lblEmployee, txtSearch: self.txtSearch, viewController: self)
        self.viewModel = EmployeeVM(binder: self.binder!)
        self.viewModel?.main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.binder?.isLoading = true
        self.viewModel?.binder?.tableView?.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.viewModel?.setIsLoading()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.binder?.isLoading = false
    }
    
    @IBAction func btnAddEmployee(_ sender: Any) {
        self.viewModel?.goToAddEmployee()
    }
}
