//
//  QualificationTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 11/01/2023.
//

import UIKit

class AcademicsTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblInstitute: UILabel!
    @IBOutlet weak var lblStartsFrom: UILabel!
    @IBOutlet weak var lblEndsTo: UILabel!
    
    //MARK: Variables
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }
    
    //MARK: Setup Label for Cell
    func setupCell() {
        self.lblCount.font = UIFont.montserratBold(14)
        self.lblDegree.font = UIFont.montserratRegular(16)
        self.lblInstitute.font = UIFont.montserratRegular(16)
        self.lblStartsFrom.font = UIFont.montserratRegular(16)
        self.lblEndsTo.font = UIFont.montserratRegular(16)
        
        self.lblView.cornerRadius(16)
    }
}
