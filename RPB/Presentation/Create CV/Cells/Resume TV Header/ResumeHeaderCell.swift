//
//  ResumeHeaderCell.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

class ResumeHeaderCell: UITableViewHeaderFooterView {
    
    //MARK: Outlet
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var btnAddMore: UIButton!
    
    //MARK: Variables
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
        self.configureButton()
    }
    
    func configureView() {
        self.headerView.borderColor = UIColor.greyE2E2E2
        self.headerView.borderWidth = 1
        self.headerView.cornerRadius(10)
    }
    
    func configureButton() {
        self.btnAddMore.titleLabel?.font = UIFont.montserratMedium(12)
        self.btnAddMore.tintColor = UIColor.customBlue
    }
    
}
