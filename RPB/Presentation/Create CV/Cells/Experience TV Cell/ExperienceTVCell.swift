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
    var startDatePicker = UIPickerView()
    var endDatePicker = UIPickerView()
    var deleteCell: (() -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configurePicker()
        self.configureTextFields()
        self.configurePickerforYear()
        self.configureTextView()
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblStartDate.font = UIFont.montserratRegular(16)
        self.lblEndDate.font = UIFont.montserratRegular(16)
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
        self.startDatePicker.delegate = self
        self.txtStartDate.inputView = startDatePicker
        self.endDatePicker.delegate = self
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
    
    //MARK: Configure PickerView for EndYear
    //    func configurePickerforEndYear() -> [String] {
    //        years = []
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyy"
    //        let date = formatter.date(from: isoDate)!
    //
    //        let startYear = Int(formatter.string(from: date)) ?? 0
    //        let currentYear = Int(formatter.string(from: Date())) ?? 0
    //
    //        for loop in stride(from: currentYear, through: startYear, by: -1) {
    //            years.append("\(loop)")
    //        }
    //        return years
    //    }
    
    //MARK: Configure PickerView for EndDate
    func configureEndDate() -> [String] {
        endDate = []
        for num in endDateIndex ..< months.count {
            endDate.append(months[num])
        }
        return endDate
    }
    
    //MARK: Configure Button
    //    func configureButton() {
    //        self.btnSave.backgroundColor = UIColor.customBlue
    //        self.btnSave.cornerRadiusButton(30)
    //        self.btnSave.tintColor = UIColor.white
    //        self.btnSave.titleLabel?.font = UIFont.montserratMedium(18)
    //    }
    
    //MARK: Configure TextView
    func configureTextView() {
        self.textView.delegate = self
        self.textView.addPadding(size: 10)
        self.textView.text = "Job Description / Responsibilities"
        self.textView.textColor = UIColor.lightGray
        self.textView.borderWidth = 1
        self.textView.borderColor = UIColor.greyE2E2E2
        self.textView.cornerRadius(10)
    }
    
    //MARK: Animation for DropDown Image
    func dropDownAnimation(imageView: [UIImageView], image: String, index: Int) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            imageView[index].image = UIImage(named: image)
        })
    }
    
    //MARK: Check Fields Validation
    func checkValidation() -> Bool {
        guard let startDate = txtStartDate.text,
              let company = txtCompany.text,
              let endDate = txtEndDate.text else {
            return false
        }
        var errorMessage: String?
        
        if company.isEmpty {
            errorMessage = "Please enter company name"
        } else if startDate.isEmpty {
            errorMessage = "Please enter start date"
        } else if endDate.isEmpty {
            errorMessage = "Please enter end date"
        }
        
        if let errorMsg = errorMessage {
            delegate?.showAlert(errorMessage: errorMsg)
            return false
        }
        return true
    }
    
    //    func adjustTextViewHeight() {
    //        let fixedWidth = textView.frame.size.width
    //        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    //        self.textViewHeight.constant = newSize.height
    //        delegate?.adjustTextViewHeight()
    //    }
    
    //MARK: IBACTION
    //    @IBAction func isSwitchPressed(_ sender: Any) {
    //        if btnSwitch.isOn == true {
    //            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [self] in endDateView.isHidden = true })
    //
    //        } else {
    //            txtEndDate.text = nil
    //            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [self] in endDateView.isHidden = false })
    //        }
    //    }
    
    //    @IBAction func btnSavePressed(_ sender: Any) {
    //        if checkValidation() {
    //            print("Data entered successfully")
    //        }
    //    }
    
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
        switch pickerView {
        case startDatePicker:
            return months.count
        case endDatePicker:
            return months.count
        default:
            return 0
            
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case startDatePicker:
            return months[row]
        case endDatePicker:
            return endDate[row]
        default:
            return ""
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == startDatePicker {
            txtStartDate.text = months[row]
            endDateIndex = row
        } else if pickerView == endDatePicker {
            txtEndDate.text = endDate[row]
        }
        delegate?.dismissPicker()
    }
}

// MARK: TextField Methods
extension ExperienceTVCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //  self.dropDownAnimation(imageView: dropDownList, image: "arrow_up", index: textField.tag)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // self.dropDownAnimation(imageView: dropDownList, image: "arrow_down", index: textField.tag)
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
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    //    func textViewDidChange(_ textView: UITextView) {
    //        self.adjustTextViewHeight()
    //    }
    
}
