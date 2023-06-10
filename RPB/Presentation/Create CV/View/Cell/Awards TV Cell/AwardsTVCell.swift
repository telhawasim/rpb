//
//  AwardsTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 08/05/2023.
//

import UIKit

class AwardsTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var cellCount: UILabel!
    @IBOutlet weak var lblAwardTitle: UILabel!
    @IBOutlet weak var txtAwardTitle: UITextField!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var countView: UIView!
    
    //MARK: Variables
    var btnDelete: (() -> Void)?
    var textViewDidChange: ((UITextView) -> Void)?
    var textFieldDidChange: ((UITextField) -> Void)?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFonts()
        self.configureViews()
        self.configureTextView()
        self.configureTextFields()
        self.txtAwardTitle.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure Fonts
    func configureFonts() {
        self.lblAwardTitle.font = UIFont.getSemiBoldFont()
        self.txtAwardTitle.font = UIFont.getMediumFont()
    }
    
    //MARK: Configure Views
    func configureViews() {
        self.countView.cornerRadius(16)
    }
    
    //MARK: Configure TextFields
    func configureTextFields() {
        self.txtAwardTitle.delegate = self
    }
    
    //MARK: Configure TextView
    func configureTextView() {
        self.txtView.delegate = self
        self.txtView.addPadding(size: 20)
        self.txtView.borderWidth = 1
        self.txtView.borderColor = UIColor.greyE2E2E2
        self.txtView.cornerRadius(10)
        self.txtView.font = UIFont.getMediumFont()
    }
    
    //MARK: Configure
    func configure(_ data: AwardsModel) {
        self.txtAwardTitle.text = data.awardTitle
        self.txtView.text = data.awardDescription
        if data.awardDescription == "" {
            self.txtView.text = "Award Description (optional)"
            self.txtView.textColor = UIColor.lightGray
        } else {
            self.txtView.text = data.awardDescription
            self.txtView.textColor = UIColor.black
        }
    }
    
    //MARK: IBActions
    @IBAction func btnDeleteCell(_ sender: Any) {
        self.btnDelete?()
    }
}

//MARK: TextView Methods
extension AwardsTVCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.textViewDidChange?(textView)
            textView.text = "Award Description (optional)"
            textView.textColor = UIColor.lightGray
        } else if textView.text != "" && textView.text != "Award Description (optional)" {
            textView.textColor = UIColor.black
            self.textViewDidChange?(textView)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 500
    }
}

// MARK: TextField Methods
extension AwardsTVCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textFieldDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 50
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}
