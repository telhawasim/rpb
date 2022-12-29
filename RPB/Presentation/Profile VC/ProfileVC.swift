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
        self.lblName.font = UIFont.montserratBold(20)
        self.lblDesignation.font = UIFont.montserratMedium(14)
        self.lblEmail.font = UIFont.montserratRegular(16)
        self.lblProfiles.font = UIFont.montserratSemiBold(24)
    }
    
    //MARK: Configure Bottom Sheet
    func configureBottomSheet() {
        self.editProfileView.isCircularView()
        self.editProfileView.backgroundColor = UIColor.blueF1F1FF
        self.lblEditProfile.font = UIFont.montserratMedium(18)
        self.deleteProfileView.isCircularView()
        self.deleteProfileView.backgroundColor = UIColor.blueF1F1FF
        self.lblDeleteProfile.font = UIFont.montserratMedium(18)
        self.downloadProfileView.isCircularView()
        self.downloadProfileView.backgroundColor = UIColor.blueF1F1FF
        self.lblDownloadProfile.font = UIFont.montserratMedium(18)
        self.bottomSheetView.cornerRadius(20)
    }
    
    //MARK: Back button on View Controller
    @IBAction func btnBack(_ sender: Any) {
        self.goBack()
    }
    
    //MARK: Add CV Button
    @IBAction func btnAddCVPressed(_ sender: Any) {
        let tabbarVC  = UIStoryboard.getVC(from: .main, ResumeCV.className)
        self.navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    //MARK: Back button in action sheet
    @IBAction func btnBottomSheetBack(_ sender: Any) {
        self.mainView.backgroundColor = UIColor.clear
        self.bottomSheetHeight.constant = 0
        self.mainView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        
    }
    
    @IBAction func btnDeleteProfile(_ sender: Any) {
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTVCell.className, for: indexPath) as? ProfileTVCell else {
            fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ProfileTVCell`")
        }
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
