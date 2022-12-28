//
//  EducationTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 27/12/2022.
//

import UIKit

class EducationTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    
    //MARK: Variables
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureLabel()
    }
    
    func configureLabel() {
        self.lblDate.font = UIFont.montserratSemiBold(16)
        self.lblYear.font = UIFont.montserratSemiBold(16)
    }
    
}
