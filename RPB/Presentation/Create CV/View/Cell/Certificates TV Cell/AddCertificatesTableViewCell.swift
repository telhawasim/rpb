//
//  AddCertificatesTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 11/01/2023.
//

import UIKit

class AddCertificatesTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var experienceCountView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var txtCourseName: UITextField!
    @IBOutlet weak var txtInstitute: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var lblCourseName: UILabel!
    @IBOutlet weak var lblInstitute: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndsTo: UILabel!
    
    //MARK: Variables
    var textCourseDidChange: ((UITextField) -> Void)?
    var textInstituteDidChange: ((UITextField) -> Void)?
    var deleteCell: (() -> Void)?
    var startDatePressed: (() -> Void)?
    var endDatePressed: (() -> Void)?
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configureTextFields()
        self.txtCourseName.addTarget(self, action: #selector(self.textFieldCourseDidChange(_:)), for: .editingChanged)
        self.txtInstitute.addTarget(self, action: #selector(self.textFieldInstituteDidChange(_:)), for: .editingChanged)
    }
    
    func configure(data: CertificatesModel) {
        self.txtCourseName.text = data.certName
        self.txtInstitute.text = data.certInstitute
        self.txtStartDate.text = data.certStartsFrom
        self.txtEndDate.text = data.certEndsTo
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblCourseName.font = UIFont.getSemiBoldFont()
        self.txtCourseName.font = UIFont.getMediumFont()
        self.lblInstitute.font = UIFont.getSemiBoldFont()
        self.txtInstitute.font = UIFont.getMediumFont()
        self.lblStartDate.font = UIFont.getSemiBoldFont()
        self.txtStartDate.font = UIFont.getMediumFont()
        self.txtStartDate.tintColor = .clear
        self.lblEndsTo.font = UIFont.getSemiBoldFont()
        self.txtEndDate.font = UIFont.getMediumFont()
        self.txtEndDate.tintColor = .clear
        self.setColors()
    }
    
    //MARK: Configure UIPicker
    func configureTextFields() {
        self.txtStartDate.delegate = self
        self.txtEndDate.delegate = self
        self.txtCourseName.delegate = self
        self.txtInstitute.delegate = self
    }
    
    //MARK: Colors
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
    }
    
    //MARK: IBACTION
    @IBAction func btnDeletePressed(_ sender: Any) {
        self.deleteCell?()
    }
    
    @IBAction func btnStartButtonPressed(_ sender: Any) {
        self.startDatePressed?()
    }
    
    @IBAction func btnEndButtonPressed(_ sender: Any) {
        self.endDatePressed?()
    }
    
}

//MARK: TextField Delegate
extension AddCertificatesTableViewCell: UITextFieldDelegate {
    @objc private func textFieldCourseDidChange(_ textField: UITextField) {
        self.textCourseDidChange?(textField)
    }
    
    @objc private func textFieldInstituteDidChange(_ textField: UITextField) {
        self.textInstituteDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txtCourseName:
            let maxLength = 50
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        case txtInstitute:
            let maxLength = 50
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        default:
            break
        }
        return true
    }
}
