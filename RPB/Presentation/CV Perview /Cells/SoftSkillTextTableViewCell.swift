//
//  SoftSkillTextTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class SoftSkillTextTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblSkills: UILabel!
    @IBOutlet weak var lblSoftSkills: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        lblSkills.textColor = UIColor.customBlack
        lblSoftSkills.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblSkills.font = UIFont.getRegularFont(size: 20)
        lblSoftSkills.font = UIFont.getDefaultFont()
        self.setColors()
    }
}
