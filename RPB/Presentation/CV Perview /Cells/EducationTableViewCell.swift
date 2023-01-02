//
//  EducationTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class EducationTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblMasterText: UILabel!
    @IBOutlet weak var lblMasterDegree: UILabel!
    @IBOutlet weak var lblSession: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        lblMasterText.textColor = UIColor.customBlack
        lblMasterDegree.textColor = UIColor.customBlack
        lblSession.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblMasterText.font = UIFont.montserratRegular(14)
        lblMasterDegree.font = UIFont.montserratThin(14)
        lblSession.font = UIFont.montserratRegular(14)
        self.setColors()
    }
}
