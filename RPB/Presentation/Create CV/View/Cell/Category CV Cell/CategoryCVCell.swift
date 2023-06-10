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
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    //MARK: Configure View
    func setupView() {
        self.cellView.borderColor = UIColor.greyE2E2E2
        self.cellView.borderWidth = 1
        self.cellView.cornerRadius(22)
    }
    
    func configure(_ isSelected: Bool, title: String) {
        self.setupCellState(isSelected)
        self.lblTitle.text = title
        self.lblTitle.font = UIFont.getRegularFont(size: 14)
        
    }
    
    func setupCellState(_ isSelected: Bool) {
        self.cellView.borderWidth = isSelected ? 0 : 1
        self.cellView.borderColor = isSelected ? UIColor.white : UIColor.greyE2E2E2
        self.cellView.backgroundColor = isSelected ? UIColor.appColor : UIColor.white
        self.lblTitle.textColor = isSelected ? UIColor.white :  UIColor.black
        
    }

}
