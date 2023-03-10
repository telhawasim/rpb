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
    var addTags: (() -> Void)?

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setColors()
        self.configureFonts()
    }
    
    // MARK: Colors
    func setColors() {
        tagsView.backgroundColor = UIColor.blueF2F5FF
        lblTagsName.textColor = UIColor.black222222
    }

    // MARK: Fonts
    func configureFonts() {
        lblTagsName.font = UIFont.montserratRegular(12)
    }
    
    @IBAction func tappedRemoveTag(_ sender: Any) {
        addTags?()
    }
}
