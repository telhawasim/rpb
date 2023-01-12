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
    var textSkillsDidChange: ((UITextField) -> Void)?

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.txtSkill.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblSkill.font = UIFont.montserratRegular(16)
        self.lblPercentage.font = UIFont.montserratRegular(16)
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

// MARK: TextField Methods
extension AddSkillsTableViewCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textSkillsDidChange?(textField)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        //  self.dropDownAnimation(imageView: dropDownList, image: "arrow_up", index: textField.tag)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // self.dropDownAnimation(imageView: dropDownList, image: "arrow_down", index: textField.tag)
    }
}

