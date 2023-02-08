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
        self.lblTitle.font = UIFont.getSemiBoldFont()
        self.txtInfo.font = UIFont.getMediumFont()
        self.txtInfo.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func configure(_ textFieldInfo: TextFieldModel) {
        self.lblTitle.text = textFieldInfo.title
        self.txtInfo.placeholder = textFieldInfo.placeholder
        self.txtInfo.text = textFieldInfo.textValue
        self.txtInfo.tag = textFieldInfo.tag
        self.txtInfo.autocapitalizationType = textFieldInfo.capitalizationType
        self.txtInfo.keyboardType = textFieldInfo.keyboardType
        
        if txtInfo.tag == 3 {
            txtInfo.delegate = self
        }
    }
}

//MARK: TexiField Methods
extension BasicInfoTVCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 3 {
            let maxLength = 11
                let currentString = (textField.text ?? "") as NSString
                let newString = currentString.replacingCharacters(in: range, with: string)

                return newString.count <= maxLength
        } else {
            return true
        }
    }
}
