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
        lblEmail.font = UIFont.montserratRegular(14)
        lblPhone.font = UIFont.montserratRegular(14)
        lblLinkedIn.font = UIFont.montserratRegular(14)
        lblBitBucket.font = UIFont.montserratRegular(14)
    }
}
