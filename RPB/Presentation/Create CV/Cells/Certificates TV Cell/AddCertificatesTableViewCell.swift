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
        self.configurePicker()
        self.txtCourseName.addTarget(self, action: #selector(self.textFieldCourseDidChange(_:)), for: .editingChanged)
        self.txtInstitute.addTarget(self, action: #selector(self.textFieldInstituteDidChange(_:)), for: .editingChanged)
        self.txtStartDate.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.txtEndDate.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
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
    
    func configure(data: AcademicsModel) {
        self.txtCourseName.text = data.txtDegree
        self.txtInstitute.text = data.txtInstitute
        self.txtStartDate.text = data.txtStartsFrom
        self.txtEndDate.text = data.txtEndsTo
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
    func configurePicker() {
        self.startYearPicker.delegate = self
        self.startYearPicker.dataSource = self
        self.endYearPicker.delegate = self
        self.endYearPicker.dataSource = self
        self.txtStartDate.inputView = startYearPicker
        self.txtEndDate.inputView = endYearPicker
        self.txtStartDate.delegate = self
        self.txtEndDate.delegate = self
    }
    
    //MARK: Colors
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
    }
    
    //MARK: Configure PickerView for Year
    func configurePickerforStartYear() -> [String] {
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
    func configurePickerforEndYear() -> [String] {
        var years: [String] = []
        let selectedYear = txtStartDate.text ?? ""
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
    
    @objc func doneButtonClicked(textField: UITextField) {
        self.txtEndDate.isUserInteractionEnabled = true
        if textField == txtStartDate {
            let selectedRow = startYearPicker.selectedRow(inComponent: 0)
            let selectedValue = startYearPicker.delegate?.pickerView?(startYearPicker, titleForRow: selectedRow, forComponent: 0)
            self.txtStartDate.text = selectedValue
            self.txtEndDate.text = ""
            self.textStartDateDidChange?(txtStartDate)
        } else {
            let selectedRow = endYearPicker.selectedRow(inComponent: 0)
            let selectedValue = endYearPicker.delegate?.pickerView?(endYearPicker, titleForRow: selectedRow, forComponent: 0)
            self.txtEndDate.text = selectedValue
            self.textEndDateDidChange?(txtEndDate)
        }
    }
    
    //MARK: IBACTION
    @IBAction func btnDeletePressed(_ sender: Any) {
        self.deleteCell?()
    }
    
}

//MARK: UIPickerView Methods
extension AddCertificatesTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == startYearPicker {
            return configurePickerforStartYear().count
        } else {
            if txtStartDate.text == "" {
                return 0
            } else {
                return configurePickerforEndYear().count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == startYearPicker {
            return configurePickerforStartYear()[row]
        } else {
            if txtStartDate.text == "" {
                return ""
            } else {
                return configurePickerforEndYear()[row]
            }
        }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtStartDate {
            if txtStartDate.text == "" {
                txtEndDate.text = ""
            }
        }
        self.txtEndDate.isUserInteractionEnabled = true
    }
}
