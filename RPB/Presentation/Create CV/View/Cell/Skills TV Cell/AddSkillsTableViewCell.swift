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
    @IBOutlet weak var txtSkill: UITextField!
    @IBOutlet weak var btnDeleteCell: UIButton!
    
    //MARK: Variables
    var deleteCell: (() -> Void)?
    var textSkillsDidChange: ((UITextField) -> Void)?

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configureTextField()
        self.txtSkill.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure
    func configure(data: SkillsModel) {
        self.txtSkill.text = data.skillName
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblcount.font = UIFont.getRegularFont()
        self.lblSkills.font = UIFont.getSemiBoldFont()
        self.txtSkill.font = UIFont.getMediumFont()
        
        self.setViews()
    }
    
    //MARK: Configure TextFields
    func configureTextField() {
        self.txtSkill.delegate = self
    }
    
    //MARK: Configure Views
    func setViews() {
        self.countView.isCircularView()
        self.countView.backgroundColor = UIColor.blueF1F1FF
    }
    
    //MARK: Delete Button Pressed
    @IBAction func tappedDeleteCell(_ sender: Any) {
        self.deleteCell?()
    }
}

// MARK: TextField Methods
extension AddSkillsTableViewCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textSkillsDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 50
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
    }
}
