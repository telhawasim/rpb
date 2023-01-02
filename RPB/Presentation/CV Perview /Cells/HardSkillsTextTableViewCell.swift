//
//  HardSkillsTextTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class HardSkillsTextTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblbHardSkills: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        lblbHardSkills.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblbHardSkills.font = UIFont.montserratRegular(16)
        self.setColors()
    }
}
