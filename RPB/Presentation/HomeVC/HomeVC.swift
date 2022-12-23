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
        tabbarView.layer.shadowColor = UIColor.red.cgColor
        tabbarView.layer.shadowOpacity = 0.5
        tabbarView.layer.shadowOffset = CGSize.zero
        tabbarView.layer.shadowRadius = 5
    }
    
    @IBAction func tappedHomeButton(_ sender: Any) {
        self.homeView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.employeeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.profileView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnHome.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnEmployee.tintColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.btnProfile.tintColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.homeTabbar()
    }
    
    @IBAction func tappedEmplooyesButton(_ sender: Any) {
        self.homeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.employeeView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.profileView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnHome.tintColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.btnEmployee.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnProfile.tintColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.employeeTabbar()
    }
    
    @IBAction func taappedProfile(_ sender: Any) {
        self.homeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.employeeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.profileView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.btnHome.tintColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.btnEmployee.tintColor = #colorLiteral(red: 0.3333333333, green: 0.3411764706, blue: 0.831372549, alpha: 1)
        self.btnProfile.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.profileTabbar()
    }
}

//MARK: Functions
extension HomeVC {
   
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
        self.addChild(HomeVC!)
        HomeVC!.didMove(toParent: self)
    }
    
    //MARK: Employee Tabbar
    func employeeTabbar(){
        let EmployeeVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeVC") as? EmployeeVC
        
        EmployeeVC!.willMove(toParent: self)
        self.containerView.addSubview(EmployeeVC!.view)
        self.addChild(EmployeeVC!)
        EmployeeVC!.didMove(toParent: self)
    }
    
    //MARK: Profile Tabbar
    func profileTabbar(){
        let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        
        ProfileVC!.willMove(toParent: self)
        self.containerView.addSubview(ProfileVC!.view)
        self.addChild(ProfileVC!)
        ProfileVC!.didMove(toParent: self)
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
