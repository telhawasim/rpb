//
//  ProfileTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import UIKit
import UIView_Shimmer

protocol ProfileDelegate: AnyObject {
    func openBottomSheet()
}

class ProfileTVCell: UITableViewCell, ShimmeringViewProtocol {

    // MARK: Outlet
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var btnOpenSheet: UIButton!

    // MARK: Variables
    var delegate: ProfileDelegate?
    
    var shimmeringAnimatedItems: [UIView] {
        [
            lblProfile,
            lblDesignation,
            lblDate,
            iconView,
            btnOpenSheet
        ]
    }
    
    // MARK: Lifecylce

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configLabel()
    }

    func configLabel() {
        self.lblProfile.font = UIFont.getBoldFont()
        self.lblDesignation.font = UIFont.getMediumFont(size: 14)
        self.lblDate.font = UIFont.getMediumFont(size: 12)
        self.lblDate.textColor = UIColor.customBlack
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
    
    @IBAction func btnOpenBottomSheet(_ sender: Any) {
        delegate?.openBottomSheet()
    }
    
}
