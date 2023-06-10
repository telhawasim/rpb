//
//  EducationTextTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class EducationTextTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblEducation: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        lblEducation.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblEducation.font = UIFont.getSemiBoldFont(size: 25)
        self.setColors()
    }
}
