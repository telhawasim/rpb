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

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.setColors()
        self.configureFonts()
    }

    // MARK: Add Employee
    @IBAction func btnAddEmployee(_ sender: Any) {
        goToAddEmployee()
    }
}

// MARK: Functions
extension HomeVC {
    // MARK: Register Cell
    func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeesTableViewCell.className)
    }

    // MARK: Set Colors
    func setColors() {
        lblName.textColor = UIColor.customBlack
        lblEmployee.textColor = UIColor.customBlack
    }

    // MARK: Set Fonts
    func configureFonts() {
        lblName.font = UIFont.getCustomFont_Medium(size: 34)
        lblEmployee.font = UIFont.getRegularFont(size: 24)
        lblEmployeeCount.font = UIFont.getCustomFont_Bold(size: 40)
    }
}

// MARK: TableView Methods
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as? EmployeesTableViewCell else {
        fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `EmployeesTableViewCell`")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToProfile()
    }
}
