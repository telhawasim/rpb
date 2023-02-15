//
//  ProfleBinder.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation
import UIKit

class ProfileBinder: NSObject {
    
    // MARK: Variables
    weak var overallView: UIView?
    weak var mainView: UIView?
    weak var btnback: UIButton?
    weak var btnAddCV: UIButton?
    weak var profilePicture: UIImageView?
    weak var lblProfiles: UILabel?
    weak var lblName: UILabel?
    weak var lblDesignation: UILabel?
    weak var lblEmail: UILabel?
    weak var tableView: UITableView?
    weak var lblEditProfile: UILabel?
    weak var lblDeleteProfile: UILabel?
    weak var lblDownloadProfile: UILabel?
    weak var editProfileView: UIView?
    weak var deleteProfileView: UIView?
    weak var downloadProfileView: UIView?
    weak var bottomSheetHeight: NSLayoutConstraint?
    weak var bottomSheetView: UIView?
    weak var viewController: UIViewController?
    
    init(overallView: UIView, mainView: UIView, btnback: UIButton, btnAddCV: UIButton, profilePicture: UIImageView, lblProfiles: UILabel, lblName: UILabel, lblDesignation: UILabel, lblEmail: UILabel, tableView: UITableView, lblEditProfile: UILabel, lblDeleteProfile: UILabel, lblDownloadProfile: UILabel, editProfileView: UIView, deleteProfileView: UIView, downloadProfileView: UIView, bottomSheetHeight: NSLayoutConstraint, bottomSheetView: UIView, viewController: UIViewController) {
        
        self.overallView = overallView
        self.mainView = mainView
        self.btnback = btnback
        self.btnAddCV = btnAddCV
        self.profilePicture = profilePicture
        self.lblProfiles = lblProfiles
        self.lblName = lblName
        self.lblDesignation = lblDesignation
        self.lblEmail = lblEmail
        self.tableView = tableView
        self.lblEditProfile = lblEditProfile
        self.lblDeleteProfile = lblDeleteProfile
        self.lblDownloadProfile = lblDownloadProfile
        self.editProfileView = editProfileView
        self.deleteProfileView = deleteProfileView
        self.downloadProfileView = downloadProfileView
        self.bottomSheetHeight = bottomSheetHeight
        self.bottomSheetView = bottomSheetView
        self.viewController = viewController
    }
    
//    var view = UIView()
    var isLoading = true {
        didSet {
            tableView?.isUserInteractionEnabled = !isLoading
            tableView?.reloadWithAnimation()
        }
    }
        
    // MARK: Configure TableView
    func configureTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(ProfileTVCell.className)
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnback?.isCircularButton()
        self.btnAddCV?.isCircularButton()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblName?.font = UIFont.getBoldFont(size: 20)
        self.lblDesignation?.font = UIFont.getMediumFont(size: 14)
        self.lblEmail?.font = UIFont.getRegularFont()
        self.lblProfiles?.font = UIFont.getRegularFont(size: 24)
    }
    
    //MARK: Configure Bottom Sheet
    func configureBottomSheet() {
        self.editProfileView?.isCircularView()
        self.editProfileView?.backgroundColor = UIColor.blueF1F1FF
        self.lblEditProfile?.font = UIFont.getMediumFont(size: 18)
        self.deleteProfileView?.isCircularView()
        self.deleteProfileView?.backgroundColor = UIColor.blueF1F1FF
        self.lblDeleteProfile?.font = UIFont.getMediumFont(size: 18)
        self.downloadProfileView?.isCircularView()
        self.downloadProfileView?.backgroundColor = UIColor.blueF1F1FF
        self.lblDownloadProfile?.font = UIFont.getMediumFont(size: 18)
        self.bottomSheetView?.cornerRadius(20)
    }
    
    //MARK: Bottom Sheet Close
    func bottomSheetClose() {
        self.mainView?.backgroundColor = UIColor.clear
        self.bottomSheetHeight?.constant = 0
        self.mainView?.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.overallView?.layoutIfNeeded()
        }
    }
    
    //MARK: Show PopUp
    func showPopUp() {
        PopupView.shared.presentPopup(viewController ?? UIViewController(), popupType: .deleteProfile)
    }
    
    //MARK: Go Back {
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Go to ResumeCV
    func goToResumeCV() {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ResumeCV.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}

//MARK: TableView Methods
extension ProfileBinder: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTVCell.className, for: indexPath) as! ProfileTVCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabbarVC  = UIStoryboard.getVC(from: .main, CVPreviewVC.className)
        self.viewController?.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
}

//MARK: ProfileVC Delegate
extension ProfileBinder: ProfileDelegate {
    func openBottomSheet() {
        self.mainView?.backgroundColor = UIColor.black
        self.mainView?.alpha = 0.6
        self.bottomSheetHeight?.constant = 230
        self.mainView?.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.overallView?.layoutIfNeeded()
        }
    }
}
