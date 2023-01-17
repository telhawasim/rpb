//
//  EmployeesTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSkills: UILabel!
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
        lblSkills.textColor = UIColor.customBlue
        lblEmail.textColor = UIColor.customBlack
    }

    // MARK: Configure Fonts
    func configureFonts() {
        lblName.font = UIFont.getDefaultFont_Bold()
        lblSkills.font = UIFont.getCustomFont_Medium(size: 14)
        lblEmail.font = UIFont.getCustomFont_Medium(size: 14)
        self.setColors()
    }
}
