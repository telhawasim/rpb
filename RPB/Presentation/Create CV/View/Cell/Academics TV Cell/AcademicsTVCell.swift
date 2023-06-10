//
//  QualificationTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 11/01/2023.
//

import UIKit
import IQKeyboardManagerSwift

class AcademicsTVCell: UITableViewCell {
    
    //MARK: Outlet
    
    //UILabel
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblInstitute: UILabel!
    @IBOutlet weak var lblStartsFrom: UILabel!
    @IBOutlet weak var lblEndsTo: UILabel!
    
    //UI TextFields
    @IBOutlet weak var txtDegree: UITextField!
    @IBOutlet weak var txtInstitute: UITextField!
    @IBOutlet weak var txtStartsFrom: UITextField!
    @IBOutlet weak var txtEndsTo: UITextField!
    @IBOutlet weak var btnDeleteCell: UIButton!
    
    //MARK: Variables
    var deleteCell: (() -> Void)?
    var textDegreeDidChange: ((UITextField) -> Void)?
    var textInstituteDidChange: ((UITextField) -> Void)?
    var startDatePressed: (() -> Void)?
    var endDatePressed: (() -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
        self.txtDegree.addTarget(self, action: #selector(self.textFieldDegreeDidChange(_:)), for: .editingChanged)
        self.txtInstitute.addTarget(self, action: #selector(self.textFieldInstituteDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Setup Label for Cell
    func setupCell() {
        self.lblCount.font = UIFont.getBoldFont(size: 14)
        self.lblDegree.font = UIFont.getSemiBoldFont()
        self.txtDegree.font = UIFont.getMediumFont()
        self.lblInstitute.font = UIFont.getSemiBoldFont()
        self.txtInstitute.font = UIFont.getMediumFont()
        self.lblStartsFrom.font = UIFont.getSemiBoldFont()
        self.txtStartsFrom.font = UIFont.getMediumFont()
        self.txtStartsFrom.tintColor = .clear
        self.lblEndsTo.font = UIFont.getSemiBoldFont()
        self.txtEndsTo.font = UIFont.getMediumFont()
        self.txtEndsTo.tintColor = .clear
        
        self.lblView.cornerRadius(16)
        
        self.txtStartsFrom.delegate = self
        self.txtEndsTo.delegate = self
        self.txtDegree.delegate = self
        self.txtInstitute.delegate = self
    }
    
    func configure(data: AcademicsModel) {
        self.txtDegree.text = data.academicDegreeName
        self.txtInstitute.text = data.academicInstitute
        self.txtStartsFrom.text = data.academicStartsFrom
        self.txtEndsTo.text = data.academicEndsTo
    }
    
    //MARK: IBACTION
    @IBAction func btnDeletePressed(_ sender: Any) {
        self.deleteCell?()
    }
    
    @IBAction func btnStartDatePressed(_ sender: Any) {
        self.startDatePressed?()
    }
    
    @IBAction func btnEndDatePressed(_ sender: Any) {
        self.endDatePressed?()
    }
}

//MARK: TextField Delegate
extension AcademicsTVCell: UITextFieldDelegate {
    @objc private func textFieldDegreeDidChange(_ textField: UITextField) {
        self.textDegreeDidChange?(textField)
    }
    
    @objc private func textFieldInstituteDidChange(_ textField: UITextField) {
        self.textInstituteDidChange?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txtDegree:
            let maxLength = 100
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        case txtInstitute:
            let maxLength = 250
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        default:
            break
        }
        return true
    }
}
