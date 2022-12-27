//
//  ProfileTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import UIKit

class ProfileTVCell: UITableViewCell {

    // MARK: Outlet
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var iconView: UIView!

    // MARK: Variables

    // MARK: Lifecylce

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configLabel()
    }

    func configLabel() {
        self.lblProfile.font = UIFont.montserratBold(18)
        self.lblDesignation.font = UIFont.montserratMedium(14)
        self.lblDate.font = UIFont.montserratRegular(12)
        self.configView()
        self.configureColor()
    }

    func configView() {
        self.outerView.borderWidth = 1
        self.outerView.cornerRadius(10)
        self.iconView.isCircularView()
    }

    func configureColor() {
        self.outerView.borderColor = UIColor.greyE2E2E2
        self.iconView.backgroundColor = UIColor.customGrey
        self.lblDesignation.textColor = UIColor.customBlue
    }
}
