//
//  EducationTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 27/12/2022.
//

import UIKit

class EducationTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    
    //MARK: Variables
    var datePicker = UIPickerView()
    var yearPicker = UIPickerView()
    var years = [String]()
    var delegate: ExperienceTVCellProtocol?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureLabel()
        self.configurePicker()
        self.configurePickerforYear()
    }
    
    func configureLabel() {
        self.lblDate.font = UIFont.getSemiBoldFont()
        self.lblYear.font = UIFont.getSemiBoldFont()
    }
    
    func configurePicker() {
        self.datePicker.delegate = self
        self.txtDate.inputView = datePicker
        self.yearPicker.delegate = self
        self.txtYear.inputView = yearPicker
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
}

extension EducationTVCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == datePicker {
            return months.count
        } else {
            return years.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == datePicker {
            return months[row]
        } else {
            return years[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == datePicker {
            txtDate.text = months[row]
        } else {
            txtYear.text = years[row]
        }
        delegate?.dismissPicker()
    }
}
