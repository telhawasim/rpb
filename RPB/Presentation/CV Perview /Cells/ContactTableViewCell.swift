//
//  ContactTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        lblContact.textColor = UIColor.customBlack
        lblEmail.textColor = UIColor.customBlack
        lblPhone.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblContact.font = UIFont.montserratSemiBold(16)
        lblEmail.font = UIFont.montserratMedium(16)
        lblPhone.font = UIFont.montserratMedium(16)
        self.setColors()
    }
}
