//
//  TagsCollectionViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 27/12/2022.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var lblTagsName: UILabel!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setColors()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        tagsView.backgroundColor = UIColor.blueF2F5FF
        lblTagsName.textColor = UIColor.customBlack
    }

    // MARK: Fonts
    func configureFonts() {
        lblTagsName.font = UIFont.montserratMedium(15)
    }
}
