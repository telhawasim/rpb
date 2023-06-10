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
        self.lblSkill.font = UIFont.getRegularFont14()
    }
    
    func configureSkills(skillsDetail: [SkillsResponse]?, skillType: String) {
        let filteredSkills = skillsDetail?.filter({$0.skillType == skillType})
        let skillsTitles = filteredSkills?.compactMap({$0.skillName}).joined(separator: ", ")
        self.lblSkill.text = skillsTitles
    }
}
