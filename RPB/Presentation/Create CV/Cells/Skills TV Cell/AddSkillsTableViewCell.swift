//
//  AddSkillsTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 11/01/2023.
//

import UIKit

class AddSkillsTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var experienceCountView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var txtSkill: UITextField!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK: Variables
    var deleteCell: (() -> Void)?

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setColors()
    }
    
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
        deleteView.backgroundColor = UIColor.dark6A90FF
    }
    
    @IBAction func tappedDeleteCell(_ sender: Any) {
        self.deleteCell?()
    }
}
