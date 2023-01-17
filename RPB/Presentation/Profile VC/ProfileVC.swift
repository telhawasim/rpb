//
//  ProfileVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class ProfileVC: BaseVC {
    
    // MARK: Outlet
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
    
    // MARK: Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButtons()
        self.configureFonts()
        self.configureTableView()
        self.configureBottomSheet()
        self.bottomSheetHeight.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadWithAnimation()
    }
    
    // MARK: Configure TableView
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProfileTVCell.className)
    }
    
    // MARK: Configure Buttons
    func configureButtons() {
        self.btnback.isCircularButton()
        self.btnAddCV.isCircularButton()
    }
    
    // MARK: Configure Fonts
    func configureFonts() {
        self.lblName.font = UIFont.getCustomFont_Bold(size: 20)
        self.lblDesignation.font = UIFont.getCustomFont_Medium(size: 14)
        self.lblEmail.font = UIFont.getRegularFont()
        self.lblProfiles.font = UIFont.getRegularFont(size: 24)
    }
    
    //MARK: Configure Bottom Sheet
    func configureBottomSheet() {
        self.editProfileView.isCircularView()
        self.editProfileView.backgroundColor = UIColor.blueF1F1FF
        self.lblEditProfile.font = UIFont.getCustomFont_Medium(size: 18)
        self.deleteProfileView.isCircularView()
        self.deleteProfileView.backgroundColor = UIColor.blueF1F1FF
        self.lblDeleteProfile.font = UIFont.getCustomFont_Medium(size: 18)
        self.downloadProfileView.isCircularView()
        self.downloadProfileView.backgroundColor = UIColor.blueF1F1FF
        self.lblDownloadProfile.font = UIFont.getCustomFont_Medium(size: 18)
        self.bottomSheetView.cornerRadius(20)
    }
    
    //MARK: Bottom Sheet Close
    func bottomSheetClose() {
        self.mainView.backgroundColor = UIColor.clear
        self.bottomSheetHeight.constant = 0
        self.mainView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Back button on View Controller
    @IBAction func btnBack(_ sender: Any) {
        self.goBack()
    }
    
    //MARK: Add CV Button
    @IBAction func btnAddCVPressed(_ sender: Any) {
        self.goToResumeCV()
    }
    
    //MARK: Back button in action sheet
    @IBAction func btnBottomSheetBack(_ sender: Any) {
        self.bottomSheetClose()
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        
    }
    
    @IBAction func btnDeleteProfile(_ sender: Any) {
        self.bottomSheetClose()
        PopupView.shared.presentPopup(self, popupType: .deleteProfile)
    }
    
    @IBAction func btnDownloadProfile(_ sender: Any) {
        
    }
    
}

//MARK: TableView Methods
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
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
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
}

//MARK: ProfileVC Delegate
extension ProfileVC: ProfileDelegate {
    func openBottomSheet() {
        self.mainView.backgroundColor = UIColor.black
        self.mainView.alpha = 0.6
        self.bottomSheetHeight.constant = 230
        self.mainView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
