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
        lblMasterText.textColor = UIColor.black222222
        lblMasterDegree.textColor = UIColor.black222222
        lblSession.textColor = UIColor.black222222
    }

    // MARK: Fonts
    func configureFonts() {
        lblMasterText.font = UIFont.montserratRegular(14)
        lblMasterDegree.font = UIFont.montserratThin(14)
        lblSession.font = UIFont.montserratRegular(14)
        self.setColors()
    }
}
