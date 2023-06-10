//
//  EmptyTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 21/03/2023.
//

import UIKit

class EmptyTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnAddHere: UIButton!
    @IBOutlet weak var icon: UIImageView!
    
    //MARK: Variables
    var addPressed: (() -> Void)?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
        self.configureButtons()
    }
    
    func setup(type: EmptyScreenType) {
        switch type {
        case .previousExperience:
            lblTitle.text = "Want to add past experience?"
        case .certificates:
            lblTitle.text = "Want to add trainings & certifications?"
        case .employeeListing:
            lblTitle.text = "No Data Available"
            lblDescription.text = "The information is not available for the moment"
            icon.image = UIImage.employeeListingEmptyIcon
            btnAddHere.isHidden = true
        case .awards:
            lblTitle.text = "Want to add awards & honors?"
        case .technicalSkills:
            lblTitle.text = "Want to add technical skills?"
        case .nonTechicalSkills:
            lblTitle.text = "Want to add non technical skills?"
        case .tools:
            lblTitle.text = "Want to add tools?"
        case .projects:
            lblTitle.text = "Want to add projects?"
        }
    }
  
    func configureFonts() {
        self.lblTitle.font = UIFont.getBoldFont(size: 22)
        self.lblDescription.font = UIFont.getRegularFont(size: 14)
    }
    
    func configureButtons() {
        self.btnAddHere.backgroundColor = UIColor.blueE2E3FF
        self.btnAddHere.tintColor = UIColor.appColor
        self.btnAddHere.cornerRadius(20)
    }
    
    @IBAction func btnAddPressed(_ sender: Any) {
        self.addPressed?()
    }
}
