//
//  BasicInfoTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit
import IQKeyboardManagerSwift

class BasicInfoTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAsterisk: UILabel!
    @IBOutlet weak var txtInfo: UITextField!
    @IBOutlet weak var dropDown: UIImageView!
    
    //MARK: Variables
    var textDidChange: ((UITextField) -> Void)?
    var designationID: ((String) -> Void)?
    var designationPicker = UIPickerView()
    var designation: [Departments]?
    var selectedDesignation: Departments?
    
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
        self.txtInfo.autocapitalizationType =  UITextAutocapitalizationType(rawValue: textFieldInfo.capitalizationType) ?? .none
        self.txtInfo.keyboardType = UIKeyboardType(rawValue: textFieldInfo.keyboardType) ?? .default
        self.dropDown.isHidden = textFieldInfo.isDropDown
        if textFieldInfo.isAsterisk {
            self.lblAsterisk.isHidden = false
        } else {
            self.lblAsterisk.isHidden = true
        }
        
        switch txtInfo.tag {
        case 0:
            txtInfo.inputView = nil
            txtInfo.delegate = self
        case 1:
            txtInfo.inputView = designationPicker
            designationPicker.delegate = self
            self.txtInfo.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        case 2:
            txtInfo.inputView = nil
        case 3:
            txtInfo.delegate = self
        case 4:
            txtInfo.inputView = nil
        case 5:
            txtInfo.inputView = nil
        case 6:
            txtInfo.inputView = nil
            txtInfo.delegate = self
        default:
            break
        }
    }
    
    @objc func doneButtonClicked(_ sender: UITextField) {
        if txtInfo.tag == 1 {
            self.selectedDesignation = self.designation?[designationPicker.selectedRow(inComponent: 0)]
            self.txtInfo?.text = self.selectedDesignation?.title
            self.textDidChange?(sender)
            self.designationID?(selectedDesignation?._id ?? "")
        }
    }
}

//MARK: PickerView Methods
extension BasicInfoTVCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return designation?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return designation?[row].title ?? ""
    }
}

//MARK: TexiField Methods
extension BasicInfoTVCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            let maxLength = 50
                let currentString = (textField.text ?? "") as NSString
                let newString = currentString.replacingCharacters(in: range, with: string)

                return newString.count <= maxLength
        }
        if textField.tag == 3 {
            let maxLength = 13
                let currentString = (textField.text ?? "") as NSString
                let newString = currentString.replacingCharacters(in: range, with: string)

                return newString.count <= maxLength
        }
        if textField.tag == 6 {
            let maxLength = 500
                let currentString = (textField.text ?? "") as NSString
                let newString = currentString.replacingCharacters(in: range, with: string)

                return newString.count <= maxLength
        } else {
            return true
        }
    }
}
