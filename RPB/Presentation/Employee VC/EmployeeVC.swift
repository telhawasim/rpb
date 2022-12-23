//
//  EmployeeVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class EmployeeVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmployee: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
    }
}

//MARK: Functions
extension EmployeeVC {
    //MARK: Register Cell
    func registerCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeesTableViewCell.className)

        self.setColors()
        self.configureFonts()
    }
    
    //MARK: Set Colors
    func setColors(){
        lblEmployee.textColor = UIColor.customBlack
    }
    
    //MARK: Set Colors
    func configureFonts(){
        lblEmployee.font = UIFont.MontserratSemiBold(24)
    }
}

//MARK: TableView Methods
extension EmployeeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as! EmployeesTableViewCell
        return cell
    }
}

