//
//  ExperienceTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 30/12/2022.
//

import UIKit
import IQKeyboardManagerSwift

class ExperienceTVCell: UITableViewCell {
    
    //MARK: Outlets
    // Labels
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    // TextFields
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    
    // UIStackView
    @IBOutlet weak var endDateStack: UIStackView!
    @IBOutlet weak var deleteStack: UIStackView!
    
    // TextView
    @IBOutlet weak var experienceCountView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    // Button
    
    //MARK: Variables
    var deleteCell: (() -> Void)?
    var textComapnyDidChange: ((UITextField) -> Void)?
    var textDesignationDidChange: ((UITextField) -> Void)?
    var textViewDidChange: ((UITextView) -> Void)?
    var tappedStartDate: (() -> Void)?
    var tappedEndDate: (() -> Void)?

    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configureTextFields()
        self.configureTextView()
        self.txtCompany.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.txtDesignation.addTarget(self, action: #selector(self.designationDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblCompany.font = UIFont.getSemiBoldFont()
        self.lblStartDate.font = UIFont.getSemiBoldFont()
        self.lblEndDate.font = UIFont.getSemiBoldFont()
        self.lblDesignation.font = UIFont.getSemiBoldFont()
        self.txtCompany.font = UIFont.getMediumFont()
        self.txtStartDate.font = UIFont.getMediumFont()
        self.txtEndDate.font = UIFont.getMediumFont()
        self.txtDesignation.font = UIFont.getMediumFont()
        self.setColors()
    }
    
    //MARK: Colors
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
    }
    
    //MARK: Configure TextFields
    func configureTextFields() {
//        self.txtCompany.delegate = self
//        self.txtDesignation.delegate = self
        self.txtStartDate.delegate = self
        self.txtEndDate.delegate = self
        self.txtStartDate.tintColor = .clear
        self.txtEndDate.tintColor = .clear
    }
    
    //MARK: Configuration in order to Data Populate
    func configure(_ textFieldInfo: ExperienceModel) {
        self.txtCompany.text = textFieldInfo.companyName
        self.txtStartDate.text = textFieldInfo.startsFrom
        self.txtEndDate.text = textFieldInfo.endsTo
        self.txtDesignation.text = textFieldInfo.designation
        if textFieldInfo.jobDescription == "" {
            self.textView.text = "Job Description / Responsibilities"
            self.textView.textColor = UIColor.lightGray
        } else {
            self.textView.text = textFieldInfo.jobDescription
            self.textView.textColor = UIColor.black
        }
    }
    
    //MARK: Configure TextView
    func configureTextView() {
        self.textView.delegate = self
        self.textView.addPadding(size: 20)
        self.textView.borderWidth = 1
        self.textView.borderColor = UIColor.greyE2E2E2
        self.textView.cornerRadius(10)
        self.textView.font = UIFont.getMediumFont()
    }
    
    //MARK: Button for Delete Cell
    @IBAction func tappedDeleteCell(_ sender: Any) {
        self.deleteCell?()
    }
    
    //MARK: Button for Start Date Picker
    @IBAction func tappedStartDate(_ sender: Any) {
        self.tappedStartDate?()
    }
    
    //MARK: Button for End Date Picker
    @IBAction func tappedEndDate(_ sender: Any) {
        self.tappedEndDate?()
    }
    
}

// MARK: TextField Methods
extension ExperienceTVCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textComapnyDidChange?(textField)
    }
    
    @objc func designationDidChange(_ textField: UITextField) {
        self.textDesignationDidChange?(textField)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == txtCompany {
//            let maxLength = 50
//            let currentString = (textField.text ?? "") as NSString
//            let newString = currentString.replacingCharacters(in: range, with: string)
//            return newString.count <= maxLength
//        } else if textField == txtDesignation {
//            let maxLength = 50
//            let currentString = (textField.text ?? "") as NSString
//            let newString = currentString.replacingCharacters(in: range, with: string)
//            return newString.count <= maxLength
//        } else {
//            return true
//        }
//    }
}

//MARK: TextView Methods
extension ExperienceTVCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.textViewDidChange?(textView)
            textView.text = "Job Description / Responsibilities"
            textView.textColor = UIColor.lightGray
        } else if textView.text != "" && textView.text != "Job Description / Responsibilities" {
            textView.textColor = UIColor.black
            self.textViewDidChange?(textView)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 500
    }
}
