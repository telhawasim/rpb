//
//  EmployeesTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit
import SkeletonView

class EmployeesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    // MARK: Variables
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    func showSkeletonForViews(tableView: UITableView) {
        Utilities.showSkeletonForViews(targetViews: [profilePicture, lblName, lblEmail, lblDesignation, imgArrow])
    }
    
    func hideSkeletonForViews(tableView: UITableView) {
        Utilities.hideSkeletonForViews(targetViews: [profilePicture, lblName, lblEmail, lblDesignation, imgArrow])
    }

    // MARK: Set Colors
    func setColors() {
        lblName.textColor = UIColor.customBlack
        lblDesignation.textColor = UIColor.appColor
        lblEmail.textColor = UIColor.customBlack
    }

    // MARK: Configure Fonts
    func configureFonts() {
        lblName.font = UIFont.getBoldFont()
        lblDesignation.font = UIFont.getMediumFont(size: 14)
        lblEmail.font = UIFont.getMediumFont(size: 14)
        self.setColors()
    }
    
    func configure(data: EmployeeListing) {
        self.lblName.text = data.name
        self.lblEmail.text = data.email
        self.lblDesignation.text = data.designation?.title
        self.profilePicture.setImageURLElsePlaceHolder(url: data.profilePicture ?? "", placeholder: UIImage.placeHolder)
    }
}
