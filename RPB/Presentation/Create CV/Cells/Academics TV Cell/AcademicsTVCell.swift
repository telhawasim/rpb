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
    
    //MARK: Variables
    var startYears: [String] = []
    var endYears: [String] = []
    var startYearPicker = UIPickerView()
    var endYearPicker = UIPickerView()
    var deleteCell: (() -> Void)?
    var textDegreeDidChange: ((UITextField) -> Void)?
    var textInstituteDidChange: ((UITextField) -> Void)?
    var textStartDateDidChange: ((UITextField) -> Void)?
    var textEndDateDidChange: ((UITextField) -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
        self.txtDegree.addTarget(self, action: #selector(self.textFieldDegreeDidChange(_:)), for: .editingChanged)
        self.txtInstitute.addTarget(self, action: #selector(self.textFieldInstituteDidChange(_:)), for: .editingChanged)
        self.txtStartsFrom.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.txtEndsTo.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.startYears = configurePickerForStartYear()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for loop in 0..<startYearPicker.numberOfComponents {
            startYearPicker.selectRow(0, inComponent: loop, animated: true)
        }
        for loop in 0..<endYearPicker.numberOfComponents {
            endYearPicker.selectRow(0, inComponent: loop, animated: true)
        }
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
        
        self.startYearPicker.delegate = self
        self.endYearPicker.delegate = self
        self.txtStartsFrom.inputView = startYearPicker
        self.txtEndsTo.inputView = endYearPicker
        self.txtStartsFrom.delegate = self
        self.txtEndsTo.delegate = self
    }
    
    func configure(data: AcademicsModel) {
        self.txtDegree.text = data.txtDegree
        self.txtInstitute.text = data.txtInstitute
        self.txtStartsFrom.text = data.txtStartsFrom
        self.txtEndsTo.text = data.txtEndsTo
    }
    
    //MARK: Configure PickerView for Year
    func configurePickerForStartYear() -> [String] {
        var years: [String] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = Int(formatter.string(from: Date())) ?? 0
        
        for year in (2000...currentYear).reversed() {
            years.append(String(year))
        }
        return years
    }
    
    //MARK: Configure PickerView for EndYear
    func configurePickerForEndYear() -> [String] {
        var years: [String] = []
        if let selectedYear = txtStartsFrom.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            guard let selectedDate = formatter.date(from: selectedYear) else {return []}
            
            let startYear = Int(formatter.string(from: selectedDate)) ?? 0
            let currentYear = Int(formatter.string(from: Date())) ?? 0
            
            for year in (startYear...currentYear).reversed() {
                years.append(String(year))
            }
            return years
        }
        return []
    }
    
    @objc func doneButtonClicked(textField: UITextField) {
        if textField == txtStartsFrom {
            let selectedRow = startYearPicker.selectedRow(inComponent: 0)
            let selectedValue = startYearPicker.delegate?.pickerView?(startYearPicker, titleForRow: selectedRow, forComponent: 0)
            self.txtStartsFrom.text = selectedValue
            self.txtEndsTo.text = ""
            self.endYears = configurePickerForEndYear()
            self.endYearPicker.reloadAllComponents()
            self.textStartDateDidChange?(txtStartsFrom)
        } else {
            let selectedRow = endYearPicker.selectedRow(inComponent: 0)
            let selectedValue = endYearPicker.delegate?.pickerView?(endYearPicker, titleForRow: selectedRow, forComponent: 0)
            self.txtEndsTo.text = selectedValue
            self.textEndDateDidChange?(txtEndsTo)
        }
    }
    
    //MARK: IBACTION
    @IBAction func btnDeletePressed(_ sender: Any) {
        self.deleteCell?()
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtStartsFrom {
            if txtStartsFrom.text == "" {
                txtEndsTo.text = ""
            }
        }
        self.txtEndsTo.isUserInteractionEnabled = true
    }
}

//MARK: UIPickerView Methods
extension AcademicsTVCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == startYearPicker {
            return startYears.count
        } else {
            if txtStartsFrom.text == "" {
                return 0
            } else {
                return endYears.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == startYearPicker {
            return startYears[row]
        } else {
            if txtStartsFrom.text == "" {
                return ""
            } else {
                return endYears[row]
            }
        }
    }
}
