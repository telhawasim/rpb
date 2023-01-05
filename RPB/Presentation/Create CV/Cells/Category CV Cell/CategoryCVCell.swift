//
//  CategoryCVCell.swift
//  RPB
//
//  Created by Telha Wasim on 05/01/2023.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: Variables
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.cellView.borderWidth = 0
                self.cellView.borderColor = UIColor.white
                self.cellView.backgroundColor = UIColor.customBlue
                self.lblTitle.textColor = UIColor.white
            } else {
                self.cellView.borderWidth = 1
                self.cellView.borderColor = UIColor.greyE2E2E2
                self.cellView.backgroundColor = UIColor.white
                self.lblTitle.textColor = UIColor.black
            }
        }
    }
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
        self.configureLabel()
    }
    
    //MARK: Configure View
    func configureView() {
        self.cellView.borderColor = UIColor.greyE2E2E2
        self.cellView.borderWidth = 1
        self.cellView.cornerRadius(22)
    }
    
    func configureLabel() {
        self.lblTitle.font = UIFont.montserratRegular(14)
        
    }

}
