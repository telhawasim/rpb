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
    weak var lblCloneProfile: UILabel?
    weak var editProfileView: UIView?
    weak var deleteProfileView: UIView?
    weak var downloadProfileView: UIView?
    weak var bottomSheetHeight: NSLayoutConstraint?
    weak var bottomSheetView: UIView?
    weak var cloneProfileView: UIView?
    weak var downloadView: UIView?
    weak var duplicateView: UIView?

    init(overallView: UIView, mainView: UIView, btnback: UIButton, btnAddCV: UIButton, profilePicture: UIImageView, lblProfiles: UILabel, lblName: UILabel, lblDesignation: UILabel, lblEmail: UILabel, tableView: UITableView, lblEditProfile: UILabel, lblDeleteProfile: UILabel, lblDownloadProfile: UILabel, lblCloneProfile: UILabel, editProfileView: UIView, deleteProfileView: UIView, downloadProfileView: UIView, bottomSheetHeight: NSLayoutConstraint, bottomSheetView: UIView, cloneProfileView: UIView, downloadView: UIView, duplicateView: UIView) {
        
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
        self.lblCloneProfile = lblCloneProfile
        self.editProfileView = editProfileView
        self.deleteProfileView = deleteProfileView
        self.downloadProfileView = downloadProfileView
        self.bottomSheetHeight = bottomSheetHeight
        self.bottomSheetView = bottomSheetView
        self.cloneProfileView = cloneProfileView
        self.downloadView = downloadView
        self.duplicateView = duplicateView
    }
    
    var profilelisting: ProfileListingResponse?
    var profileDetail: ResumeResponse?
    var employeeModel: EmployeeDetail?
    var selectedIndex: Int?
    var didTapPreviewAt: ((String) -> Void)?
    var didTapCreateProfile: (() -> Void)?
        
    // MARK: Configure TableView
    func configureTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(ProfileTVCell.className)
        self.tableView?.register(EmptyProfileTVCell.className)
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnback?.isCircularButton()
        self.btnAddCV?.isCircularButton()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblName?.font = UIFont.getBoldFont(size: 20)
        self.lblDesignation?.font = UIFont.getMediumFont14()
        self.lblEmail?.font = UIFont.getRegularFont(size: 14)
        self.lblProfiles?.font = UIFont.getMediumFont(size: 25)
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
        self.lblCloneProfile?.font = UIFont.getMediumFont(size: 18)
        self.cloneProfileView?.isCircularView()
        self.cloneProfileView?.backgroundColor = UIColor.blueF1F1FF
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
    
    //MARK: Populate Data 
    func populateData(response: EmployeeDetail) {
        self.lblName?.text = response.data?.name
        self.lblDesignation?.text = response.data?.designation?.title
        self.lblEmail?.text = response.data?.email
        if let url = response.data?.profilePicture {
            self.profilePicture?.setImage(url: url)
        } else {
            self.profilePicture?.image = UIImage(named: response.data?.profilePicture ?? "")
        }
        UIView.animate(withDuration: 1.0) {
            self.lblName?.alpha = 1
            self.lblDesignation?.alpha = 1
            self.lblEmail?.alpha = 1
            self.profilePicture?.alpha = 1
        }
    }
}

//MARK: TableView Methods
extension ProfileBinder: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profilelisting?.data == nil {
            return 4
        } else if profilelisting?.data?.count == 0 {
            return 1
        } else {
            return profilelisting?.data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if profilelisting?.data?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyProfileTVCell.className, for: indexPath) as! EmptyProfileTVCell
            cell.selectionStyle = .none
            cell.btnPressed = {
                self.didTapCreateProfile?()
            }
            cell.configureConstraint()
            self.lblProfiles?.isHidden = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTVCell.className, for: indexPath) as! ProfileTVCell
            cell.selectionStyle = .none
            cell.indexPath = indexPath.row
            cell.delegate = self
            self.lblProfiles?.isHidden = false
            
            if let data = profilelisting?.data {
                cell.hideSkeletonForViews(tableView: tableView)
                cell.configure(data: data[indexPath.row])
            } else {
                cell.showSkeletonForViews(tableView: tableView)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = self.profilelisting?.data else { return }
        
        if !data.isEmpty {
            guard let experience = data[indexPath.row].experiences,
                  let academics = data[indexPath.row].academics
            else { return }
            if (data[indexPath.row].profileStatus == "COMPLETED" || !experience.isEmpty && !academics.isEmpty) {
                self.didTapPreviewAt?(data[indexPath.row].id ?? "" )
            } else {
                
            }
        }
    }
}

//MARK: ProfileVC Delegate
extension ProfileBinder: ProfileDelegate {
    func openBottomSheet(indexPath: Int, isCompleted: Bool) {
        if isCompleted {
            self.downloadView?.isHidden = false
            self.duplicateView?.isHidden = false
            self.bottomSheetHeight?.constant = 270
        } else {
            self.downloadView?.isHidden = true
            self.duplicateView?.isHidden = true
            self.bottomSheetHeight?.constant = 180
        }
        self.selectedIndex = indexPath
        self.mainView?.backgroundColor = UIColor.black
        self.mainView?.alpha = 0.6
        self.mainView?.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.overallView?.layoutIfNeeded()
        }
    }
}
