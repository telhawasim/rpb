//
//  EmployeesTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!

    // MARK: Variables

    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }

    // MARK: Set Colors
    func setColors() {
        lblName.textColor = UIColor.customBlack
        lblDesignation.textColor = UIColor.customBlue
        lblEmail.textColor = UIColor.customBlack
    }

    // MARK: Configure Fonts
    func configureFonts() {
        lblName.font = UIFont.getBoldFont()
        lblDesignation.font = UIFont.getMediumFont(size: 14)
        lblEmail.font = UIFont.getMediumFont(size: 14)
        self.setColors()
    }
    
    func configure(data: HomeModel) {
        self.profilePicture.image = UIImage(named: data.profilePicture)
        self.lblName.text = data.name
        self.lblEmail.text = data.email
        self.lblDesignation.text = data.designation
    }
    
}
