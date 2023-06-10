//
//  EmptyProfileTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 21/03/2023.
//

import UIKit

class EmptyProfileTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    
    //MARK: Variables
    var btnPressed: (() -> Void)?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
        self.configureButton()
    }
    
    func configureFonts() {
        self.lblTitle.font = UIFont.getSemiBoldFont(size: 21)
        self.lblDescription.font = UIFont.getRegularFont()
    }
    
    func configureButton() {
        self.btnAdd.backgroundColor = UIColor.appColor
        self.btnAdd.tintColor = UIColor.white
        self.btnAdd.titleLabel?.font = UIFont.getBoldFont(size: 16)
        self.btnAdd.cornerRadius(25)
    }
    
    func configureConstraint() {
        self.topContraint.constant = 20
    }
    
    @IBAction func btnCreatePressed(_ sender: Any) {
        self.btnPressed?()
    }
}
