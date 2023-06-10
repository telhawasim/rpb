//
//  ProfileTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import UIKit

protocol ProfileDelegate: AnyObject {
    func openBottomSheet(indexPath: Int, isCompleted: Bool)
}

class ProfileTVCell: UITableViewCell {

    // MARK: Outlet
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDraft: UILabel!
    @IBOutlet weak var draftView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var btnOpenSheet: UIButton!

    // MARK: Variables
    var delegate: ProfileDelegate?
    var indexPath: Int?
    var isCompleted: Bool = false
    
    // MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configLabel()
        self.configView()
        self.configureColor()
    }

    func configLabel() {
        self.lblProfile.font = UIFont.getBoldFont()
        self.lblDesignation.font = UIFont.getMediumFont14()
        self.lblDesignation.textColor = UIColor.appColor
        self.lblDate.font = UIFont.getRegularFont14()
        self.lblDate.textColor = UIColor.customBlack
        self.lblDraft.font = UIFont.getBoldFont(size: 12)
        self.lblDraft.textColor = UIColor.appColor
    }

    func configView() {
        self.outerView.borderWidth = 1
        self.outerView.cornerRadius(10)
        self.iconView.isCircularView()
        self.draftView.backgroundColor = UIColor.blueE2E3FF
        self.draftView.cornerRadius(8)
    }

    func configureColor() {
        self.outerView.borderColor = UIColor.greyE2E2E2
        self.iconView.backgroundColor = UIColor.customGrey
        self.lblDesignation.textColor = UIColor.appColor
    }
    
    func configure(data: ProfileListing) {
        guard let experience = data.experiences,
              let academics = data.academics
        else { return }
        
        self.lblProfile.text = data.profileName
        self.lblDate.text = data.createdAt?.convertToDate()?.toLocalTime().getEventListingDate() ?? DefaultValue.string
        self.lblDesignation.text = data.basicInfo?.designation?.title
        if data.profileStatus == "COMPLETED" || (!experience.isEmpty && !academics.isEmpty) {
            self.draftView.isHidden = true
            self.isCompleted = true
        } else {
            self.draftView.isHidden = false
            self.isCompleted = false
        }
    }
    
    func showSkeletonForViews(tableView: UITableView) {
        Utilities.showSkeletonForViews(targetViews: [iconView, lblProfile, lblDesignation, lblDate, btnOpenSheet])
        self.draftView.isHidden = true
    }
    
    func hideSkeletonForViews(tableView: UITableView) {
        Utilities.hideSkeletonForViews(targetViews: [iconView, lblProfile, lblDesignation, lblDate, btnOpenSheet])
        self.draftView.isHidden = false
    }
    
    @IBAction func btnOpenBottomSheet(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        delegate?.openBottomSheet(indexPath: indexPath, isCompleted: self.isCompleted)
    }
    
}
