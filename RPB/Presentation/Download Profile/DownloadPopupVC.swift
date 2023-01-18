//
//  DownloadPopupVC.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import UIKit

class DownloadPopupVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var individualView: UIView!
    @IBOutlet weak var agencyView: UIView!
    @IBOutlet weak var individualBtnView: UIView!
    @IBOutlet weak var agencyBtnView: UIView!
    @IBOutlet weak var lblDownloadSection: UILabel!
    @IBOutlet weak var lblIndividual: UILabel!
    @IBOutlet weak var lblIndividualDescription: UILabel!
    @IBOutlet weak var btnIndividual: UIButton!
    @IBOutlet weak var lblIndividualName: UILabel!
    @IBOutlet weak var btnIndividualName: UIButton!
    @IBOutlet weak var lblIndividualPhone: UILabel!
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
        self.lblIndividualDescription.font = UIFont.getMediumFont(size: 14)
        self.lblIndividualName.font = UIFont.getMediumFont(size: 14)
        self.lblIndividualPhone.font = UIFont.getMediumFont(size: 14)
    }
    
    func configureColor() {
        self.lblIndividual.textColor = UIColor.customBlue
    }
    
    func configureButton() {
        self.btnDone.backgroundColor = UIColor.customBlue
        self.btnDone.cornerRadiusButton(30)
    }
    
    
    @IBAction func tappedIndividual(_ sender: Any) {
        self.btnIndividual.isSelected = !btnIndividual.isSelected
    }
    
    @IBAction func tappedIndividualName(_ sender: Any) {
        self.btnIndividualName.isSelected = !btnIndividualName.isSelected
    }
    
    @IBAction func tappedIndividualPhone(_ sender: Any) {
        self.btnIndividualPhone.isSelected = !btnIndividualPhone.isSelected
    }
    
}
