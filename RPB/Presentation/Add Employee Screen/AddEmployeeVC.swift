//
//  AddEmployeeVC.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import UIKit

class AddEmployeeVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK: Variables
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFont()
        self.configureAddButton()
    }
    
    //MARK: Configure Font
    func configureFont() {
        self.lblTitle.font = UIFont.MontserratMedium(24)
        self.profileImage.isCircular()
    }
    
    //MARK: Configure Add Button
    func configureAddButton() {
        self.btnAdd.cornerRadius(30)
        self.btnAdd.backgroundColor = UIColor.customBlue
        self.btnAdd.setTitleColor(UIColor.white, for: .normal)
        self.btnAdd.setTitle("Add", for: .normal)
    }
    
}
