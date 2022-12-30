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
    // UIImageView
    @IBOutlet weak var dropDownEmploymentType: UIImageView!
    @IBOutlet weak var dropDownLocationType: UIImageView!
    @IBOutlet weak var dropDownStartDate: UIImageView!
    @IBOutlet weak var dropDownEndDate: UIImageView!
    // Switch
    @IBOutlet weak var btnSwitch: UISwitch!
    // UIStackView
    @IBOutlet weak var endDateView: UIStackView!
    
    //MARK: Variables
    var delegate: ExperienceTVCellProtocol?
    var employmentTypePicker = UIPickerView()
    var locationTypePicker = UIPickerView()
    var startDatePicker = UIPickerView()
    var endDatePicker = UIPickerView()
    var employmentType = ["", "Full-Time", "Part-Time", "Contract", "Overseas", "Trainee"]
    var locationType = ["", "On-Site", "Hybrid", "Remote"]
    var months = ["", "January", "February", "March", "April", "May", "June", "July", "August", "Spetember", "Octuber", "November", "December"]
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configurePicker()
        self.configureTextFields()
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
        self.txtEndDate.inputView = endDatePicker
    }
    
    //MARK: Configure TextFields
    func configureTextFields() {
        self.txtEmploymentType.delegate = self
        self.txtLocationType.delegate = self
        self.txtStartDate.delegate = self
        self.txtEndDate.delegate = self
    }
    
    //MARK: Animation for DropDown Image
    func dropDownAnimation(imageView: UIImageView, image: String) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            imageView.image = UIImage(named: image)
        })
    }
    
    //MARK: IBACTION
    @IBAction func isSwitchPressed(_ sender: Any) {
        if btnSwitch.isOn == true {
            endDateView.isHidden = true
        } else {
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
        }
        delegate?.dismissPicker()
    }
}

// MARK: TextField Methods
extension ExperienceTVCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtEmploymentType {
            self.dropDownAnimation(imageView: dropDownEmploymentType, image: "arrow_up")
        } else if textField == txtLocationType {
            self.dropDownAnimation(imageView: dropDownLocationType, image: "arrow_up")
        } else if textField == txtStartDate {
            self.dropDownAnimation(imageView: dropDownStartDate, image: "arrow_up")
        } else if textField == txtEndDate {
            self.dropDownAnimation(imageView: dropDownEndDate, image: "arrow_up")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtEmploymentType {
            self.dropDownAnimation(imageView: dropDownEmploymentType, image: "arrow_down")
        } else if textField == txtLocationType {
            self.dropDownAnimation(imageView: dropDownLocationType, image: "arrow_down")
        } else if textField == txtStartDate {
            self.dropDownAnimation(imageView: dropDownStartDate, image: "arrow_down")
        } else if textField == txtEndDate {
            self.dropDownAnimation(imageView: dropDownEndDate, image: "arrow_down")
        }
    }
}
