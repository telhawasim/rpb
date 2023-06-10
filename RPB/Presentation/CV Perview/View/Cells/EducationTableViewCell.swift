//
//  EducationTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class EducationTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var lblMasterText: UILabel!
    @IBOutlet weak var lblMasterDegree: UILabel!
    @IBOutlet weak var lblSession: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        lblMasterText.textColor = UIColor.customBlack
        lblMasterDegree.textColor = UIColor.customBlack
        lblSession.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblMasterText.font = UIFont.getSemiBoldFont(size: 16)
        lblMasterDegree.font = UIFont.getRegularFont14()
        lblSession.font = UIFont.getRegularFont14()
        self.setColors()
    }
    
    func configure(educationdetail: AcademicsResponse?) {
        self.lblMasterText.text = educationdetail?.academicDegreeName
        self.lblMasterDegree.text = educationdetail?.academicInstitute
        self.lblSession.text = "\(educationdetail?.academicStartsFrom?.prefix(4) ?? "")-\(educationdetail?.academicEndsTo?.prefix(4) ?? "")"
    }
    
    func configureCertificates(certificatesDetail: CertificatesResponse?) {
        self.lblMasterText.text = certificatesDetail?.certName
        self.lblMasterDegree.text = certificatesDetail?.certInstitute
        self.lblSession.text = "\(certificatesDetail?.certStartsFrom?.prefix(4) ?? "")-\(certificatesDetail?.certEndsTo?.prefix(4) ?? "")"
    }
}
