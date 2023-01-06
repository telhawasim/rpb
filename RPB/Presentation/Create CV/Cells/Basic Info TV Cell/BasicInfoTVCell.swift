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
    var txtTitles = ["Name", "Designation", "Email Address", "Phone Number", "Git / Bit Bucket", "LinkedIn"]
    var txtPlaceholder = ["Dawid", "UI/UX Designer", "dawid.name@gmail.com", "03350438764", "Dawid.name@bitbucket.org", "linkedin.com/dawid.name"]
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
    }
    
    func configureFont() {
        self.lblTitle.font = UIFont.montserratRegular(16)
    }
    
    func configureInfoSection(index: Int) {
        self.lblTitle.text = txtTitles[index]
        self.txtInfo.placeholder = txtPlaceholder[index]
        
        switch index {
        case 0:
            self.txtInfo.autocapitalizationType = .words
            self.txtInfo.text = ""
        case 1:
            self.txtInfo.autocapitalizationType = .words
            self.txtInfo.text = ""
        case 2:
            self.txtInfo.keyboardType = .emailAddress
            self.txtInfo.autocapitalizationType = .none
            self.txtInfo.text = ""
        case 3:
            self.txtInfo.keyboardType = .decimalPad
            self.txtInfo.delegate = self
            self.txtInfo.text = ""
        case 4:
            self.txtInfo.autocapitalizationType = .words
            self.txtInfo.text = ""
        case 5:
            self.txtInfo.autocapitalizationType = .none
            self.txtInfo.text = ""
        default:
            print("")
        }
    }
}

//MARK: TexiField Methods
extension BasicInfoTVCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtInfo {
            let maxLength = 11
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            
            return newString.count <= maxLength
        } else {
            return Bool()
        }
    }
}
