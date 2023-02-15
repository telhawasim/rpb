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
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var deleteProfileView: UIView!
    @IBOutlet weak var downloadProfileView: UIView!
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomSheetView: UIView!
    
    // MARK: Variables
    var binder: ProfileBinder?
    var viewModel: ProfileVM?
    
    // MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binder = ProfileBinder(overallView: self.overallView, mainView: self.mainView, btnback: self.btnback, btnAddCV: self.btnAddCV, profilePicture: self.profilePicture, lblProfiles: self.lblProfiles, lblName: self.lblName, lblDesignation: self.lblDesignation, lblEmail: self.lblEmail, tableView: self.tableView, lblEditProfile: self.lblEditProfile, lblDeleteProfile: self.lblDeleteProfile, lblDownloadProfile: self.lblDownloadProfile, editProfileView: self.editProfileView, deleteProfileView: self.deleteProfileView, downloadProfileView: self.downloadProfileView, bottomSheetHeight: self.bottomSheetHeight, bottomSheetView: self.bottomSheetView, viewController: self)
        
        viewModel = ProfileVM(binder: self.binder!)
        
        viewModel?.main()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.binder?.isLoading = true
        self.viewModel?.binder?.tableView?.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.viewModel?.setIsLoading()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.binder?.isLoading = false
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
    
    @IBAction func btnEditProfile(_ sender: Any) {
        
    }
    
    @IBAction func btnDeleteProfile(_ sender: Any) {
        self.viewModel?.deleteButtonPressed()
    }
    
    @IBAction func btnDownloadProfile(_ sender: Any) {
        
    }
    
}
