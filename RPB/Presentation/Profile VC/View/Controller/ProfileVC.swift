//
//  ProfileVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class ProfileVC: BaseVC {
    
    // MARK: Outlet
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnAddCV: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblProfiles: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var lblDeleteProfile: UILabel!
    @IBOutlet weak var lblDownloadProfile: UILabel!
    @IBOutlet weak var lblCloneProfile: UILabel!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var deleteProfileView: UIView!
    @IBOutlet weak var downloadProfileView: UIView!
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var cloneProfileView: UIView!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var duplicateView: UIView!
    
    // MARK: Variables
    var binder: ProfileBinder?
    var viewModel: ProfileVM?
    
    // MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binder = ProfileBinder(overallView: self.overallView, mainView: self.mainView, btnback: self.btnback, btnAddCV: self.btnAddCV, profilePicture: self.profilePicture, lblProfiles: self.lblProfiles, lblName: self.lblName, lblDesignation: self.lblDesignation, lblEmail: self.lblEmail, tableView: self.tableView, lblEditProfile: self.lblEditProfile, lblDeleteProfile: self.lblDeleteProfile, lblDownloadProfile: self.lblDownloadProfile, lblCloneProfile: self.lblCloneProfile, editProfileView: self.editProfileView, deleteProfileView: self.deleteProfileView, downloadProfileView: self.downloadProfileView, bottomSheetHeight: self.bottomSheetHeight, bottomSheetView: self.bottomSheetView, cloneProfileView: self.cloneProfileView, downloadView: self.downloadView, duplicateView: self.duplicateView)
        
        if viewModel == nil {
            viewModel = ProfileVM(binder: self.binder!, viewController: self)
        } else {
            viewModel?.binder = self.binder
            viewModel?.viewController = self
        }
        viewModel?.main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.apiCall()
    }
    
    //MARK: Back button on View Controller
    @IBAction func btnBack(_ sender: Any) {
        self.viewModel?.goBack()
    }
    
    //MARK: Add CV Button
    @IBAction func btnAddCVPressed(_ sender: Any) {
        self.viewModel?.goToResumeCV()
    }
    
    //MARK: Back button in action sheet
    @IBAction func btnBottomSheetBack(_ sender: Any) {
        self.viewModel?.closeButtonSheet()
    }
    
    //MARK: Edit Profile Button
    @IBAction func btnEditProfile(_ sender: Any) {
        self.viewModel?.editProfile()
    }
    
    //MARK: Delete Profile Button
    @IBAction func btnDeleteProfile(_ sender: Any) {
        self.viewModel?.deleteProfile()
    }
    
    //MARK: Download Profile Button
    @IBAction func btnDownloadProfile(_ sender: Any) {
        self.viewModel?.goToDownloadProfile()
    }
    
    @IBAction func btnCloneProfile(_ sender: Any) {
        self.viewModel?.goToCloneProfile()
    }
}
