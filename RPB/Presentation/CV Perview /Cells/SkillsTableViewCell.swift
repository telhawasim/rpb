//
//  SkillsTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var lblSkill: UILabel!
    
    //MARK: Variables
   
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    func configureFonts() {
        self.lblSkill.font = UIFont.getGilroyMediumFont(size: 16)
    }
}
