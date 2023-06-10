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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filtercollectionView: UICollectionView!
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var overallView: UIView!
    
    // MARK: Variables
    var binder: EmployeeBinder?
    var viewModel: EmployeeVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.binder = EmployeeBinder(tableView: self.tableView, collectionView: self.filtercollectionView, lblEmployee: self.lblEmployee, txtSearch: self.txtSearch, mainView: self.mainView, bottomSheetHeight: self.bottomSheetHeight, bottomSheetView: self.bottomSheetView)
        
        if viewModel == nil {
            viewModel = EmployeeVM(binder: self.binder!, viewController: self)
        } else {
            viewModel?.binder = self.binder
            viewModel?.viewController = self
        }
        self.viewModel?.main()
        self.binder?.bottomSheetView?.isHidden = true
        self.binder?.bottomSheetHeight?.constant = 0
        self.viewModel?.fetchEmployeeListing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.fetchDepartments()
    }
    
    // MARK: Add Employee Button Pressed
    @IBAction func btnAddEmployee(_ sender: Any) {
        self.viewModel?.goToAddEmployee()
    }
    
    // MARK: Filter Button Pressed
    @IBAction func btnFilterPressed(_ sender: Any) {
        self.binder?.showFilter()
    }
    
    // MARK: Bottom Sheet Button Pressed
    @IBAction func btnBottomSheetPressed(_ sender: Any) {
        self.binder?.hideFilter()
    }
}
