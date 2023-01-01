//
//  ExperienceTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 30/12/2022.
//

import UIKit

protocol ExperienceTVCellProtocol {
    func dismissPicker()
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
    @IBOutlet weak var txtEmploymentType: UITextField!
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
    
    //MARK: Variables
    var delegate: ExperienceTVCellProtocol?
    var years = [String]()
    var employmentTypePicker = UIPickerView()
    var locationTypePicker = UIPickerView()
    var startDatePicker = UIPickerView()
    var endDatePicker = UIPickerView()
    var startYearPicker = UIPickerView()
    var endYearPicker = UIPickerView()
    var employmentType = ["", "Full-Time", "Part-Time", "Contract", "Overseas", "Trainee"]
    var locationType = ["", "On-Site", "Hybrid", "Remote"]
    var months = ["", "January", "February", "March", "April", "May", "June", "July", "August", "Spetember", "Octuber", "November", "December"]
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
    }
    
    //MARK: Configure Labels
    func configureFont() {
        self.lblTitle.font = UIFont.montserratSemiBold(16)
        self.lblEmploymentType.font = UIFont.montserratSemiBold(16)
        self.lblCompanyName.font = UIFont.montserratSemiBold(16)
        self.lblLocation.font = UIFont.montserratSemiBold(16)
        self.lblLocationType.font = UIFont.montserratSemiBold(16)
        self.lblCurrentlyWorking.font = UIFont.montserratMedium(16)
        self.lblStartDate.font = UIFont.montserratSemiBold(16)
        self.lblEndDate.font = UIFont.montserratSemiBold(16)
        self.lblStartYear.font = UIFont.montserratSemiBold(16)
        self.lblEndYear.font = UIFont.montserratSemiBold(16)
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
    
    //MARK: Configure PickerView for Year
    func configurePickerforYear() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = Int(formatter.string(from: Date())) ?? 0
        
        for loop in stride(from: 2000, through: currentYear, by: 1) {
            years.append("\(loop)")
        }
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
        case endDatePicker:
            return months.count
        case startYearPicker:
            return years.count
        case endYearPicker:
            return years.count
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
            return months[row]
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
        } else if pickerView == endDatePicker {
            txtEndDate.text = months[row]
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
}
