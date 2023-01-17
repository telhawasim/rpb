//
//  ExperienceTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 30/12/2022.
//

import UIKit

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
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateView: UIView!
    
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
        self.configurePickerforYear()
        self.configureTextView()
        self.txtCompany.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblCompany.font = UIFont.getRegularFont()
        self.lblStartDate.font = UIFont.getRegularFont()
        self.lblEndDate.font = UIFont.getRegularFont()
        self.setColors()
    }
    
    //MARK: Colors
    func setColors() {
        experienceCountView.backgroundColor = UIColor.blueF1F1FF
        deleteView.backgroundColor = UIColor.dark6A90FF
        startDateView.backgroundColor = UIColor.dark6A90FF
        endDateView.backgroundColor = UIColor.dark6A90FF
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
    }
    
    //MARK: Configure PickerView for StartYear
    func configurePickerforYear() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = Int(formatter.string(from: Date())) ?? 0
        
        for loop in stride(from: currentYear, through: 2000, by: -1) {
            years.append("\(loop)")
        }
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
    
    //MARK: Configure PickerView for EndYear
        func configurePickerforEndYear() -> [String] {
            years = []
            let selectedStartDate = txtStartDate.text ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            let date = formatter.date(from: selectedStartDate)!
    
            let startYear = Int(formatter.string(from: date)) ?? 0
            let currentYear = Int(formatter.string(from: Date())) ?? 0
    
            for loop in stride(from: currentYear, through: startYear, by: -1) {
                years.append("\(loop)")
            }
            return years
        }
    
    //MARK: Configure PickerView for EndDate
    func configureEndDate() -> [String] {
        endDate = []
        for num in endDateIndex ..< months.count {
            endDate.append(months[num])
        }
        return endDate
    }
    
    //MARK: Configure TextView
    func configureTextView() {
        self.textView.delegate = self
        self.textView.addPadding(size: 20)
        self.textView.borderWidth = 1
        self.textView.borderColor = UIColor.greyE2E2E2
        self.textView.cornerRadius(10)
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
            self.textStartDateDidChange?(txtStartDate)
        } else {
            txtEndDate.text = years[row]
            self.textEndDateDidChange?(txtEndDate)
        }
        delegate?.dismissPicker()
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
