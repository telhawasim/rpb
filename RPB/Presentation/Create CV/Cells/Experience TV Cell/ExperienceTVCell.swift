//
//  ExperienceTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 30/12/2022.
//

import UIKit

class ExperienceTVCell: UITableViewCell {
    //MARK: Outlet
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmploymentType: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationType: UILabel!
    //MARK: Variables
    
    //MARK: Lifecylce

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureLabel()
    }
    
    //MARK: Configure Labels
    func configureLabel() {
    }
    
}
