//
//  ExperienceTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblSkills: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblSession: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
        self.setColors()
    }
    
    // MARK: Colors
    func setColors() {
        lblSkills.textColor = UIColor.black222222
        lblCompany.textColor = UIColor.black222222
        lblExperience.textColor = UIColor.black222222
        lblSession.textColor = UIColor.black222222
    }

    // MARK: Fonts
    func configureFonts() {
        lblSkills.font =  UIFont.montserratRegular(16)
        lblCompany.font = UIFont.montserratThin(16)
        lblExperience.font = UIFont.montserratThin(16)
        lblSession.font = UIFont.montserratRegular(14)
    }
}
