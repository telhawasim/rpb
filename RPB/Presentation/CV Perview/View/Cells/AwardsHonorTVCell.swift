//
//  AwardsHonorTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 11/05/2023.
//

import UIKit

class AwardsHonorTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var awardTitle: UILabel!
    @IBOutlet weak var awardDescription: UILabel!
    
    //MARK: Variables
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
    }
    
    func configureAwards(awardsData: AwardsAndHonorsResponse?) {
        self.awardTitle.text = awardsData?.awardTitle ?? ""
        self.awardDescription.text = awardsData?.awardDescription ?? ""
        
        if awardsData?.awardDescription == "" {
            awardDescription.frame.size.height = 0
        }
    }

    func configureFonts() {
        self.awardTitle.font = UIFont.getSemiBoldFont(size: 18)
        self.awardDescription.font = UIFont.getRegularFont14()
    }
    
}
