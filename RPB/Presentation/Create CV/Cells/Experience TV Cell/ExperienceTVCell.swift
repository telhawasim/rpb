//
//  ExperienceTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 30/12/2022.
//

import UIKit
import IQKeyboardManagerSwift

protocol ExperienceTVCellProtocol {
    func dismissPicker()
    func adjustTextViewHeight()
    func showAlert(errorMessage: String)
}

class ExperienceTVCell: UITableViewCell {
    
    //MARK: Outlets
    // Labels
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    // TextFields
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    
    // UIStackView
    @IBOutlet weak var endDateStack: UIStackView!
    @IBOutlet weak var deleteStack: UIStackView!
    
    // TextView
    @IBOutlet weak var experienceCountView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Variables
    var delegate: ExperienceTVCellProtocol?
    var years = [String]()
    var endDate = [String]()
    var endDateIndex = Int()
    var startYearPicker = UIPickerView()
    var endYearPicker = UIPickerView()
    var deleteCell: (() -> Void)?
    var textComapnyDidChange: ((UITextField) -> Void)?
    var textStartDateDidChange: ((UITextField) -> Void)?
    var textEndDateDidChange: ((UITextField) -> Void)?
    var textViewDidChange: ((UITextView) -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configurePicker()
        self.configureTextFields()
        self.configureTextView()
        self.txtCompany.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.txtStartDate.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.txtEndDate.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblCompany.font = UIFont.getSemiBoldFont()
        self.lblStartDate.font = UIFont.getSemiBoldFont()
        self.lblEndDate.font = UIFont.getSemiBoldFont()
        self.txtCompany.font = UIFont.getMediumFont()
        self.txtStartDate.font = UIFont.getMediumFont()
        self.txtEndDate.font = UIFont.getMediumFont()
        self.setColors()
    }
    
    //MARK: Colors
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
    }
    
    //MARK: Configure UIPickerView
    func configurePicker() {
        self.startYearPicker.delegate = self
        self.endYearPicker.delegate = self
        self.txtStartDate.inputView = startYearPicker
        self.txtEndDate.inputView = endYearPicker
    }
    
    //MARK: Configure TextFields
    func configureTextFields() {
        self.txtStartDate.delegate = self
        self.txtStartDate.tag = 2
        self.txtEndDate.delegate = self
        self.txtEndDate.tag = 4
        self.txtStartDate.tintColor = .clear
        self.txtEndDate.tintColor = .clear
    }
    
    //MARK: Configure PickerView for StartYear
    func configurePickerForStartYear() -> [String] {
        years = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = Int(formatter.string(from: Date())) ?? 0
        
        for loop in stride(from: currentYear, through: 2000, by: -1) {
            years.append("\(loop)")
        }
        return years
    }
    
    //MARK: Configure PickerView for EndYear
        func configurePickerForEndYear() -> [String] {
            years = []
            let selectedStartDate = txtStartDate.text ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            guard let date = formatter.date(from: selectedStartDate) else { return [String()] }
    
            let startYear = Int(formatter.string(from: date)) ?? 0
            let currentYear = Int(formatter.string(from: Date())) ?? 0
    
            for loop in stride(from: currentYear, through: startYear, by: -1) {
                years.append("\(loop)")
            }
            return years
        }
    
    func configure(_ textFieldInfo: ExperienceModel) {
        self.txtCompany.text = textFieldInfo.txtCompanyName
        self.txtStartDate.text = textFieldInfo.txtStartDate
        self.txtEndDate.text = textFieldInfo.txtEndDate
        if textFieldInfo.txtView == "" {
            self.textView.text = "Job Description / Responsibilities"
            self.textView.textColor = UIColor.lightGray
        } else {
            self.textView.text = textFieldInfo.txtView
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
    
    @objc func doneButtonClicked(textField: UITextField) {
        if textField == txtStartDate {
            if txtStartDate.text == "" {
                self.startYearPicker.selectRow(0, inComponent: 0, animated: true)
                self.txtStartDate.text = self.configurePickerForStartYear().first
                self.textStartDateDidChange?(txtStartDate)
            }
        } else {
            if txtEndDate.text == "" {
                self.endYearPicker.selectRow(0, inComponent: 0, animated: true)
                self.txtEndDate.text = self.configurePickerForEndYear().first
                self.textEndDateDidChange?(txtEndDate)
            }
        }
    }
    
    @IBAction func tappedDeleteCell(_ sender: Any) {
        self.deleteCell?()
    }
}

// MARK: UIPickerView Methods
extension ExperienceTVCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == startYearPicker {
            return configurePickerForStartYear().count
        } else {
            return configurePickerForEndYear().count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == startYearPicker {
            return configurePickerForStartYear()[row]
        } else {
            return configurePickerForEndYear()[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == startYearPicker {
            txtStartDate.text =  configurePickerForStartYear()[row]
            self.txtEndDate.text = ""
            self.textStartDateDidChange?(txtStartDate)
        } else {
            txtEndDate.text = configurePickerForEndYear()[row]
            self.textEndDateDidChange?(txtEndDate)
        }
    }
}

// MARK: TextField Methods
extension ExperienceTVCell: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textComapnyDidChange?(textField)
    }
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
            self.textViewDidChange?(textView)
        }
    }
}
