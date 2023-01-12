//
//  AddCertificatesTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 11/01/2023.
//

import UIKit

protocol AddCertificatesTVCellProtocol {
    func dismissPicker()
}

class AddCertificatesTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var experienceCountView: UIView!
    @IBOutlet weak var deleteView: UIView!
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
    var delegate: AddCertificatesTVCellProtocol?
    var textCourseDidChange: ((UITextField) -> Void)?
    var textInstituteDidChange: ((UITextField) -> Void)?
    var textStartDateDidChange: ((UITextField) -> Void)?
    var textEndDateDidChange: ((UITextField) -> Void)?
    var startYearPicker = UIPickerView()
    var endYearPicker = UIPickerView()
    var deleteCell: (() -> Void)?
    var years = [String]()

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.txtCourseName.addTarget(self, action: #selector(self.textCourseDidChange(_:)), for: .editingChanged)
        self.txtInstitute.addTarget(self, action: #selector(self.textInstituteDidChange(_:)), for: .editingChanged)
        self.txtStartDate.addTarget(self, action: #selector(self.textStartDateDidChange(_:)), for: .editingChanged)
        self.txtEndDate.addTarget(self, action: #selector(self.textEndDateDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblCourseName.font = UIFont.montserratRegular(16)
        self.lblInstitute.font = UIFont.montserratRegular(16)
        self.lblStartDate.font = UIFont.montserratRegular(16)
        self.lblEndsTo.font = UIFont.montserratRegular(16)
        self.setColors()
    }
    
    //MARK: Colors
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
        deleteView.backgroundColor = UIColor.dark6A90FF
    }
}

// MARK: UIPickerView Methods
extension AddCertificatesTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == startYearPicker {
            return years.count
        } else {
            return years.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == startYearPicker {
            return years[row]
        } else {
            return years[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == startYearPicker {
            txtStartDate.text =  years[row]
            self.textStartDateDidChange(txtStartDate)
        } else {
            txtEndDate.text = years[row]
            self.textEndDateDidChange(txtEndDate)
        }
        delegate?.dismissPicker()
    }
}

// MARK: TextField Methods
extension AddCertificatesTableViewCell: UITextFieldDelegate {
    @objc func textCourseDidChange(_ textField: UITextField) {
        self.textCourseDidChange?(textField)
    }
    
    @objc func textStartDateDidChange(_ textField: UITextField) {
        self.textStartDateDidChange?(textField)
    }
    
    @objc func textInstituteDidChange(_ textField: UITextField) {
        self.textInstituteDidChange?(textField)
    }
    
    @objc func textEndDateDidChange(_ textField: UITextField) {
        self.textEndDateDidChange?(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //  self.dropDownAnimation(imageView: dropDownList, image: "arrow_up", index: textField.tag)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // self.dropDownAnimation(imageView: dropDownList, image: "arrow_down", index: textField.tag)
    }
}
