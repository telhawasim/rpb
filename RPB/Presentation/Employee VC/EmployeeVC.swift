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
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.setColors()
        self.configureFonts()
        self.configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadWithAnimation()
    }
    
    @IBAction func btnAddEmployee(_ sender: Any) {
        goToAddEmployee()
    }
}

// MARK: Functions
extension EmployeeVC {
    
    // MARK: Register Cell
    func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeesTableViewCell.className)
    }
    
    // MARK: Colors
    func setColors() {
        lblEmployee.textColor = UIColor.customBlack
    }
    
    // MARK: Fonts
    func configureFonts() {
        lblEmployee.font = UIFont.getCustomFont_Medium(size: 24)
    }
    
    // MARK: Configure TextField
    func configureTextField() {
        txtSearch.attributedPlaceholder = NSAttributedString(string: Localization.Employee.search, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black222222, NSAttributedString.Key.font: UIFont.montserratMedium(14)])
        txtSearch.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlack, NSAttributedString.Key.font: UIFont.getCustomFont_Medium(size: 14)])
    }
}

// MARK: TableView Methods
extension EmployeeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as! EmployeesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToProfile()
    }
}
