//
//  DownloadPopupVC.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import UIKit

class DownloadPopupVC: UIViewController {
    
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
    @IBOutlet weak var btnIndividualName: UIButton!
    @IBOutlet weak var btnIndividualPhone: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK: Variables
    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFont()
        self.configureColor()
        self.configureView()
        self.configureButton()
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
    
    func configureFont() {
        self.lblDownloadSection.font = UIFont.getMediumFont()
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
        self.lblIndividual.textColor = UIColor.customBlue
        self.lblAgency.textColor = UIColor.customBlue
    }
    
    func configureButton() {
        self.btnDone.backgroundColor = UIColor.customBlue
        self.btnDone.cornerRadiusButton(30)
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
    
    @IBAction func tappedIndividualName(_ sender: Any) {
        self.btnIndividualName.isSelected = !btnIndividualName.isSelected
    }
    
    @IBAction func tappedIndividualPhone(_ sender: Any) {
        self.btnIndividualPhone.isSelected = !btnIndividualPhone.isSelected
    }
    
}
