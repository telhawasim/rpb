//
//  ProfileTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import UIKit

class ProfileTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var iconView: UIView!
    //MARK: Variables
    
    //MARK: Lifecylce

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configLabel() {
        self.lblProfile.font = UIFont.MontserratBold(18)
        self.lblDesignation.font = UIFont.MontserratMedium(14)
        self.lblDesignation.textColor = UIColor.customBlue
        self.lblDate.font = UIFont.MontserratRegular(12)
    }
    
    func configView() {
        self.outerView.borderColor = UIColor.greyE2E2E2
        self.outerView.borderWidth = 1
        self.outerView.cornerRadius(10)
        self.iconView.isCircularView()
        self.iconView.backgroundColor = UIColor.customGrey
    }

    
}
