//
//  HomeVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var employeeView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var tabbarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmployeeCount: UILabel!
    @IBOutlet weak var lblTotalEmployee: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmployee: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        
    }
    
    @IBAction func tappedHomeButton(_ sender: Any) {
        self.homeTabbar()
    }
    
    @IBAction func tappedEmplooyesButton(_ sender: Any) {
        self.employeeTabbar()
    }
    
    @IBAction func taappedProfile(_ sender: Any) {
        self.profileTabbar()
    }
}

//MARK: Functions
extension HomeVC {
    //MARK: Register Cell
    func registerCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmployeesTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeesTableViewCell")
    }
    
    //MARK: Home Tabbar
    func homeTabbar(){
        let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        HomeVC!.willMove(toParent: self)
        self.containerView.addSubview(HomeVC!.view)
        HomeVC!.didMove(toParent: self)
        self.homeColor()
    }
    
    //MARK: Employee Tabbar
    func employeeTabbar(){
        let EmployeeVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeVC") as? EmployeeVC
        
        EmployeeVC!.willMove(toParent: self)
        self.containerView.addSubview(EmployeeVC!.view)
        EmployeeVC!.didMove(toParent: self)
        self.employeeColor()
    }
    
    //MARK: Profile Tabbar
    func profileTabbar(){
        let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        ProfileVC!.willMove(toParent: self)
        self.containerView.addSubview(ProfileVC!.view)
        ProfileVC!.didMove(toParent: self)
        self.ProfileColor()
    }
    
    //MARK: Set Colors
    func setColors(){
        lblEmployeeCount.textColor = UIColor.white
        lblName.textColor = UIColor.customBlack
        lblEmployee.textColor = UIColor.customBlack
    }
    
    //MARK: Set Colors
    func configureFonts(){
        lblName.font = UIFont.MontserratBold(32)
        lblEmployee.font = UIFont.MontserratSemiBold(24)
    }
    
    //MARK: Home Tabbar Color
    func homeColor(){
        self.homeView.backgroundColor = UIColor.customBlue
        self.employeeView.backgroundColor = UIColor.white
        self.profileView.backgroundColor = UIColor.white
        self.btnHome.tintColor = UIColor.white
        self.btnEmployee.tintColor = UIColor.customBlue
        self.btnProfile.tintColor = UIColor.customBlue
    }
    
    //MARK: Employee Tabbar Color
    func employeeColor(){
        self.homeView.backgroundColor = UIColor.white
        self.employeeView.backgroundColor = UIColor.customBlue
        self.profileView.backgroundColor = UIColor.white
        self.btnHome.tintColor = UIColor.customBlue
        self.btnEmployee.tintColor = UIColor.white
        self.btnProfile.tintColor = UIColor.customBlue
    }
    
    //MARK: Profile Tabbar Color
    func ProfileColor(){
        self.homeView.backgroundColor = UIColor.white
        self.employeeView.backgroundColor = UIColor.white
        self.profileView.backgroundColor = UIColor.customBlue
        self.btnHome.tintColor = UIColor.customBlue
        self.btnEmployee.tintColor = UIColor.customBlue
        self.btnProfile.tintColor = UIColor.white
    }
}

//MARK: TableView Methods
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeesTableViewCell")!
        return cell
    }
}
