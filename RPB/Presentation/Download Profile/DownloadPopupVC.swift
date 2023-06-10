//
//  DownloadPopupVC.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import UIKit

class DownloadPopupVC: BaseVC {
    
    //MARK: Outlet
    
    //UIViews
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var individualView: UIView!
    @IBOutlet weak var agencyView: UIView!
    @IBOutlet weak var individualBtnView: UIView!
    @IBOutlet weak var agencyBtnView: UIView!
    
    //UILabels
    @IBOutlet weak var lblDownloadSection: UILabel!
    @IBOutlet weak var lblIndividual: UILabel!
    @IBOutlet weak var lblIndividualDescription: UILabel!
    @IBOutlet weak var lblIndividualName: UILabel!
    @IBOutlet weak var lblIndividualPhone: UILabel!
    @IBOutlet weak var lblIndividualLinkedIn: UILabel!
    @IBOutlet weak var lblIndividualEmail: UILabel!
    @IBOutlet weak var lblIndividualGit: UILabel!
    @IBOutlet weak var lblAgency: UILabel!
    @IBOutlet weak var lblAgencyDescription: UILabel!
    @IBOutlet weak var lblAgencyEmail: UILabel!
    @IBOutlet weak var lblAgencyPhone: UILabel!
    @IBOutlet weak var lblAgencyElements: UILabel!
    @IBOutlet weak var lblAgencyWebLink: UILabel!
    @IBOutlet weak var lblAgencyAddress: UILabel!
    @IBOutlet weak var lblAgencyLogo: UILabel!
    
    //UIButtons
    @IBOutlet weak var btnIndividual: UIButton!
    @IBOutlet weak var btnAgency: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var individualName: UIButton!
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var linkdin: UIButton!
    @IBOutlet weak var btnemail: UIButton!
    @IBOutlet weak var btnGit: UIButton!
    
    //MARK: Variables
    var flag = false
    var individualNameBool: Bool = true
    var individualPhone: Bool = true
    var individualLinkedin: Bool = true
    var individualEmail: Bool = true
    var individualGit: Bool = true
    var individualProfileImage: Bool = true
    var agencyEmailBool: Bool = true
    var agencyPhoneNumber: Bool = true
    var agencyLogoIcon: Bool = true
    var agencyAddresss: Bool = true
    var agencyWebLinkBool: Bool = true
    var agencyElementsBool: Bool = true
    
    var profileID: String?
    var buttons = [UIButton]()
    var isNavigationProfile: Bool = false
    var profileDetail: ResumeResponse?
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFont()
        self.configureColor()
        self.configureView()
        self.configureButton()
        self.setButtonImage()
        self.fetchProfileDetail()
    }
    
    func configureView() {
        self.mainView.cornerRadius(20)
        self.individualView.cornerRadius(20)
        self.individualView.borderWidth = 1
        self.individualView.borderColor = UIColor.blueEEEEFF
        self.individualBtnView.backgroundColor = UIColor.blueEEEEFF
        
        self.agencyView.cornerRadius(20)
        self.agencyView.borderWidth = 1
        self.agencyView.borderColor = UIColor.blueEEEEFF
        self.agencyBtnView.backgroundColor = UIColor.blueEEEEFF
    }
    
    func setButtonImage() {
        let imgName = flag ? "ic_unselected_fields" : "selectedIcon"
        let image1 = UIImage(named: "\(imgName).png")!
        self.btnIndividual.setImage(image1, for: .normal)
    }
    
    func configureFont() {
        self.lblDownloadSection.font = UIFont.getMediumFont(size: 18)
        self.lblIndividual.font = UIFont.getSemiBoldFont()
        self.lblIndividualDescription.font = UIFont.getMediumFont14()
        self.lblAgency.font = UIFont.getSemiBoldFont()
        self.lblAgencyDescription.font = UIFont.getMediumFont14()
        self.lblIndividualName.font = UIFont.getMediumFont14()
        self.lblIndividualPhone.font = UIFont.getMediumFont14()
        self.lblIndividualLinkedIn.font = UIFont.getMediumFont14()
        self.lblIndividualEmail.font = UIFont.getMediumFont14()
        self.lblIndividualGit.font = UIFont.getMediumFont14()
        self.lblAgencyEmail.font = UIFont.getMediumFont14()
        self.lblAgencyPhone.font = UIFont.getMediumFont14()
        self.lblAgencyLogo.font = UIFont.getMediumFont14()
        self.lblAgencyAddress.font = UIFont.getMediumFont14()
        self.lblAgencyWebLink.font = UIFont.getMediumFont14()
        self.lblAgencyElements.font = UIFont.getMediumFont14()
    }
    
    func configureColor() {
        self.lblIndividual.textColor = UIColor.customBlack
        self.lblAgency.textColor = UIColor.customBlack
    }
    
    func configureButton() {
        self.btnDone.backgroundColor = UIColor.appColor
        self.btnDone.cornerRadiusButton(30)
    }
    
    @IBAction func tappedGoBack(_ sender: Any) {
        if isNavigationProfile {
            self.navigationController?.popToViewController(ofClass: ProfileVC.self)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func tappedSelection(_ sender: UIButton) {
        if sender == btnIndividual {
            self.btnIndividual.isSelected = true
            self.btnAgency.isSelected = false
        } else if sender == btnAgency {
            self.btnIndividual.isSelected = false
            self.btnAgency.isSelected = true
        }
    }
    
    @IBAction func tappedCheckBoxesButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.individualNameBool = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.individualNameBool = false
            }
            sender.isSelected = !sender.isSelected
            
        case 2:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.individualPhone = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.individualPhone = false
            }
            sender.isSelected = !sender.isSelected
            
        case 3:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.individualEmail = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.individualEmail = false
            }
            sender.isSelected = !sender.isSelected
            
        case 4:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.individualLinkedin = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.individualLinkedin = false
            }
            sender.isSelected = !sender.isSelected
        case 5:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.individualGit = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.individualGit = false
            }
            sender.isSelected = !sender.isSelected
            
        case 6:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.individualProfileImage = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.individualProfileImage = false
            }
            sender.isSelected = !sender.isSelected
            
        case 7:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.agencyEmailBool = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.agencyEmailBool = false
            }
            sender.isSelected = !sender.isSelected
            
        case 8:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.agencyPhoneNumber = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.agencyPhoneNumber = false
            }
            sender.isSelected = !sender.isSelected
            
        case 9:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.agencyLogoIcon = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.agencyLogoIcon = false
            }
            sender.isSelected = !sender.isSelected
            
        case 10:
            
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.agencyWebLinkBool = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.agencyWebLinkBool = false
            }
            sender.isSelected = !sender.isSelected
            
        case 11:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.agencyAddresss = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.agencyAddresss = false
            }
            sender.isSelected = !sender.isSelected
            
        case 12:
            if sender.isSelected {
                sender.setImage(UIImage(named: "selectedIcon"), for: .normal)
                self.agencyElementsBool = true
            } else {
                sender.setImage(UIImage(named: "unCheck"), for: .normal)
                self.agencyElementsBool = false
            }
            sender.isSelected = !sender.isSelected
            
        default:
            print("Failed")
        }
    }
    
    func saveResumePDF(pdfData: Data) {
        let date = Date()
        let formatterData = date.getFormattedDate(format: DateFormat.yyyy_mm_dd)
        let fileName = "\(profileDetail?.data?.profileName ?? "")-\(formatterData)"
        FilesManager.shared.savePdf(pdfData: pdfData, fileName: fileName) { response in
            switch response {
            case .success((_, _)):
                AlertHandler.shared.alert(message: "PDF Downloaded Sucessfully", title: "PDF Download", completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        self.callExportPdf()
    }
    
    //MARK: API Calling for Info Information
    func callExportPdf() {
        var bodyParams = [ParameterKeys.profileId: self.profileID,
                          ParameterKeys.individualName: individualNameBool,
                          ParameterKeys.individualPhone: individualPhone,
                          ParameterKeys.individualEmail: individualEmail,
                          ParameterKeys.individualLinkedin: individualLinkedin,
                          ParameterKeys.individualProfileImage: individualProfileImage,
                          ParameterKeys.individualGit: individualGit,
                          ParameterKeys.agencyEmail: agencyPhoneNumber,
                          ParameterKeys.agencyPhone: agencyPhoneNumber,
                          ParameterKeys.agencyAddress: agencyAddresss,
                          ParameterKeys.agencyLogo: agencyLogoIcon,
                          ParameterKeys.agencyWebLink: agencyWebLinkBool
        ] as [String: Any]
        DispatchQueue.main.async {
            Loader.start()
        }
        UserService.shared.exportPDF(body: bodyParams) { response in
            DispatchQueue.main.async {
                Loader.stop()
            }
            DispatchQueue.main.async {
                switch response {
                case .success(let savePDf):
                    self.saveResumePDF(pdfData: savePDf)
                case .failure(let error):
                    AlertHandler.shared.alert(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: API CALLS
    func fetchProfileDetail() {
        UserService.shared.fetchProfileDetail(id: self.profileID ?? "") { response in
            switch response {
            case .success(let userResponse):
                self.profileDetail = userResponse
            case .failure(let error):
                AlertHandler.shared.alert(message: error.localizedDescription)
            }
        }
    }
}
