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
    @IBOutlet weak var linkedInStack: UIStackView!
    @IBOutlet weak var gitLinkStack: UIStackView!

    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }

    // MARK: Fonts
    func configureFonts() {
        lblContact.font = UIFont.getSemiBoldFont(size: 25)
        lblEmail.font = UIFont.getMediumFont(size: 14)
        lblEmail.textColor = UIColor.customBlack
        lblPhone.font = UIFont.getMediumFont(size: 14)
        lblPhone.textColor = UIColor.customBlack
        lblLinkedIn.font = UIFont.getMediumFont(size: 14)
        lblLinkedIn.textColor = UIColor.customBlack
        lblBitBucket.font = UIFont.getMediumFont(size: 14)
        lblBitBucket.textColor = UIColor.customBlack
    }
    
    func configure(contactDetail: BasicInfoResponse?) {
        self.lblEmail.text = contactDetail?.email
        self.lblLinkedIn.text = contactDetail?.linkedLink
        self.lblBitBucket.text = contactDetail?.gitLink
        self.lblPhone.text = contactDetail?.phone?.formatPhoneNumberWithHyphen()
        
        if contactDetail?.linkedLink == "" || contactDetail?.linkedLink == nil {
            self.linkedInStack.isHidden = true
        } else {
            self.linkedInStack.isHidden = false
        }
        
        if contactDetail?.gitLink == "" || contactDetail?.gitLink == nil {
            self.gitLinkStack.isHidden = true
        } else {
            self.gitLinkStack.isHidden = false
        }
    }
}
