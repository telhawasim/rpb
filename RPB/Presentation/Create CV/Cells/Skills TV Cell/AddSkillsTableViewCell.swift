//
//  AddSkillsTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 11/01/2023.
//

import UIKit

class AddSkillsTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var lblcount: UILabel!
    @IBOutlet weak var lblSkills: UILabel!
    @IBOutlet weak var lblInPercentage: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var txtSkill: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    //MARK: Variables
    var deleteCell: (() -> Void)?
    var textSkillsDidChange: ((UITextField) -> Void)?

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.slider.maximumTrackTintColor = UIColor.white
        self.slider.minimumTrackTintColor = UIColor.blueEAEDFE
        self.txtSkill.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblcount.font = UIFont.montserratBold(14)
        self.lblSkills.font = UIFont.montserratRegular(16)
        self.lblInPercentage.font = UIFont.montserratRegular(16)
        self.lblPercentage.font = UIFont.montserratRegular(16)
        self.txtSkill.font = UIFont.montserratRegular(16)
        
        self.setViews()
    }
    
    func setViews() {
        self.countView.isCircularView()
        self.countView.backgroundColor = UIColor.blueF1F1FF
    }
    
    @IBAction func tappedDeleteCell(_ sender: Any) {
        self.deleteCell?()
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        var value = Int(sender.value)
        self.lblPercentage.text = "\(value) %"
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

