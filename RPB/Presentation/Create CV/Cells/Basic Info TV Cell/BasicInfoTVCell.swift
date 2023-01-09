//
//  BasicInfoTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

class BasicInfoTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtInfo: UITextField!
    
    //MARK: Variables
    var textDidChange: ((UITextField) -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.font = UIFont.montserratRegular(16)
        self.txtInfo.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func configure(_ textFieldInfo: TextFieldModel) {
        self.lblTitle.text = textFieldInfo.title
        self.txtInfo.placeholder = textFieldInfo.placeholder
        self.txtInfo.text = textFieldInfo.textValue
        self.txtInfo.tag = textFieldInfo.tag
        self.txtInfo.autocapitalizationType = textFieldInfo.capitalizationType
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
}

//MARK: TexiField Methods
extension BasicInfoTVCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textDidChange?(textField)
    }
}
