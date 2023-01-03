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
    
    //MARK: Outlet
    
    // Labels
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmploymentType: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationType: UILabel!
    @IBOutlet weak var lblCurrentlyWorking: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartYear: UILabel!
    @IBOutlet weak var lblEndYear: UILabel!
    
    // TextFields
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtEmploymentType: UITextField!
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtLocationType: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartYear: UITextField!
    @IBOutlet weak var txtEndYear: UITextField!
    
    // UIImageView
    @IBOutlet weak var dropDownEmploymentType: UIImageView!
    @IBOutlet weak var dropDownLocationType: UIImageView!
    @IBOutlet weak var dropDownStartDate: UIImageView!
    @IBOutlet weak var dropDownEndDate: UIImageView!
    @IBOutlet weak var dropDownStartYear: UIImageView!
    @IBOutlet weak var dropDownEndYear: UIImageView!
    
    // Switch
    @IBOutlet weak var btnSwitch: UISwitch!
    
    // UIStackView
    @IBOutlet weak var endDateView: UIStackView!
    
    // TextView
    @IBOutlet weak var textView: UITextView!
    
    // Button
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    //MARK: Variables
    var delegate: ExperienceTVCellProtocol?
    var years = [String]()
    var endDate = [String]()
    var endDateIndex = Int()
    var employmentTypePicker = UIPickerView()
    var locationTypePicker = UIPickerView()
    var startDatePicker = UIPickerView()
    var endDatePicker = UIPickerView()
    var startYearPicker = UIPickerView()
    var endYearPicker = UIPickerView()
    lazy var dropDownList: [UIImageView] = [dropDownEmploymentType, dropDownLocationType, dropDownStartDate, dropDownStartYear, dropDownEndDate, dropDownEndYear]
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configurePicker()
        self.configureTextFields()
        self.configurePickerforYear()
        self.configureButton()
        self.configureTextView()
        //        self.textViewHeight = textView.heightAnchor.constraint(equalToConstant: 40)
        //        self.textViewHeight.isActive = true
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblTitle.font = UIFont.montserratRegular(16)
        self.lblEmploymentType.font = UIFont.montserratRegular(16)
        self.lblCompanyName.font = UIFont.montserratRegular(16)
        self.lblLocation.font = UIFont.montserratRegular(16)
        self.lblLocationType.font = UIFont.montserratRegular(16)
        self.lblCurrentlyWorking.font = UIFont.montserratRegular(16)
        self.lblStartDate.font = UIFont.montserratRegular(16)
        self.lblEndDate.font = UIFont.montserratRegular(16)
        self.lblStartYear.font = UIFont.montserratRegular(16)
        self.lblEndYear.font = UIFont.montserratRegular(16)
    }
    
    //MARK: Configure UIPickerView
    func configurePicker() {
        self.employmentTypePicker.delegate = self
        self.txtEmploymentType.inputView = employmentTypePicker
        self.locationTypePicker.delegate = self
        self.txtLocationType.inputView = locationTypePicker
        self.startDatePicker.delegate = self
        self.txtStartDate.inputView = startDatePicker
        self.endDatePicker.delegate = self
        self.txtStartYear.inputView = startYearPicker
        self.endYearPicker.delegate = self
        self.txtEndDate.inputView = endDatePicker
        self.startYearPicker.delegate = self
        self.txtEndYear.inputView = endYearPicker
    }
    
    //MARK: Configure TextFields
    func configureTextFields() {
        self.txtEmploymentType.delegate = self
        self.txtEmploymentType.tag = 0
        self.txtLocationType.delegate = self
        self.txtLocationType.tag = 1
        self.txtStartDate.delegate = self
        self.txtStartDate.tag = 2
        self.txtStartYear.delegate = self
        self.txtStartYear.tag = 3
        self.txtEndDate.delegate = self
        self.txtEndDate.tag = 4
        self.txtEndYear.delegate = self
        self.txtEndYear.tag = 5
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
    func configurePickerforEndYear() -> [String] {
        years = []
        let isoDate = "\(txtStartYear.text ?? "")"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = formatter.date(from: isoDate)!
        
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
    
    //MARK: Configure Button
    func configureButton() {
        self.btnSave.backgroundColor = UIColor.customBlue
        self.btnSave.cornerRadiusButton(30)
        self.btnSave.tintColor = UIColor.white
        self.btnSave.titleLabel?.font = UIFont.montserratMedium(18)
    }
    
    //MARK: Configure TextView
    func configureTextView() {
        self.textView.delegate = self
        self.textView.addPadding(size: 10)
        self.textView.text = "Description"
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
        guard let title = txtTitle.text,
              let employmentType = txtEmploymentType.text,
              let company = txtCompany.text,
              let location = txtLocation.text,
              let locationType = txtLocationType.text,
              let startDate = txtStartDate.text,
              let startYear = txtStartYear.text,
              let endDate = txtEndDate.text,
              let endYear = txtEndYear.text else {
            return false
        }
        var errorMessage: String?
        
        if title.isEmpty {
            errorMessage = "Please enter job title"
        } else if employmentType.isEmpty {
            errorMessage = "Please enter employment type"
        } else if company.isEmpty {
            errorMessage = "Please enter company name"
        } else if location.isEmpty {
            errorMessage = "Please enter location"
        } else if locationType.isEmpty {
            errorMessage = "Please enter location type"
        } else if startDate.isEmpty {
            errorMessage = "Please enter start date"
        } else if startYear.isEmpty {
            errorMessage = "Please enter start year"
        } else if btnSwitch.isOn == false {
            if endDate.isEmpty {
                errorMessage = "Please enter end date"
            } else if endYear.isEmpty {
                errorMessage = "Please enter end year"
            }
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
    @IBAction func isSwitchPressed(_ sender: Any) {
        if btnSwitch.isOn == true {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [self] in endDateView.isHidden = true })
            
        } else {
            txtEndDate.text = nil
            txtEndYear.text = nil
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [self] in endDateView.isHidden = false })
        }
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        if checkValidation() {
            print("Data entered successfully")
        }
    }
}

// MARK: UIPickerView Methods
extension ExperienceTVCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case employmentTypePicker:
            return employmentType.count
        case locationTypePicker:
            return locationType.count
        case startDatePicker:
            return months.count
        case startYearPicker:
            return years.count
        case endDatePicker:
            if txtEndYear.text != "" && txtStartYear.text == txtEndYear.text {
                return configureEndDate().count
            } else if txtStartYear.text != txtEndYear.text {
                return months.count
            } else {
                return 0
            }
        case endYearPicker:
            if txtStartYear.text != "" {
                return configurePickerforEndYear().count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case employmentTypePicker:
            return employmentType[row]
        case locationTypePicker:
            return locationType[row]
        case startDatePicker:
            return months[row]
        case endDatePicker:
            if txtEndYear.text != txtStartYear.text {
                return months[row]
            } else {
                return endDate[row]
            }
        case startYearPicker:
            return years[row]
        case endYearPicker:
            return years[row]
        default:
            return ""
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == employmentTypePicker {
            txtEmploymentType.text = employmentType[row]
        } else if pickerView == locationTypePicker {
            txtLocationType.text = locationType[row]
        } else if pickerView == startDatePicker {
            txtStartDate.text = months[row]
            endDateIndex = row
        } else if pickerView == endDatePicker {
            if txtEndYear.text != txtStartYear.text {
                txtEndDate.text = months[row]
            } else {
                txtEndDate.text = endDate[row]
            }
        } else if pickerView == startYearPicker {
            txtStartYear.text = years[row]
        } else if pickerView == endYearPicker {
            txtEndYear.text = years[row]
        }
        delegate?.dismissPicker()
    }
}

// MARK: TextField Methods
extension ExperienceTVCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dropDownAnimation(imageView: dropDownList, image: "arrow_up", index: textField.tag)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.dropDownAnimation(imageView: dropDownList, image: "arrow_down", index: textField.tag)
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
