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
        lblContact.font = UIFont.montserratRegular(24)
        lblEmail.font = UIFont.montserratMedium(14)
        lblEmail.textColor = UIColor.black222222
        lblPhone.font = UIFont.montserratMedium(14)
        lblPhone.textColor = UIColor.black222222
        lblLinkedIn.font = UIFont.montserratMedium(14)
        lblLinkedIn.textColor = UIColor.black222222
        lblBitBucket.font = UIFont.montserratMedium(14)
        lblBitBucket.textColor = UIColor.black222222
    }
}
