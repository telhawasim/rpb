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
    @IBOutlet weak var lblLinkedIn: UILabel!
    @IBOutlet weak var lblBitBucket: UILabel!

    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }

    // MARK: Fonts
    func configureFonts() {
        lblContact.font = UIFont.getRegularFont(size: 22)
        lblEmail.font = UIFont.getMediumFont(size: 14)
        lblEmail.textColor = UIColor.customBlack
        lblPhone.font = UIFont.getMediumFont(size: 14)
        lblPhone.textColor = UIColor.customBlack
        lblLinkedIn.font = UIFont.getMediumFont(size: 14)
        lblLinkedIn.textColor = UIColor.customBlack
        lblBitBucket.font = UIFont.getMediumFont(size: 14)
        lblBitBucket.textColor = UIColor.customBlack
    }
}
