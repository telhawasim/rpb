//
//  QualificationTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 11/01/2023.
//

import UIKit

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
    var delegate: ExperienceTVCellProtocol?
    var years = [String]()
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
    }
    
    //MARK: Setup Label for Cell
    func setupCell() {
        self.lblCount.font = UIFont.montserratBold(14)
        self.lblDegree.font = UIFont.montserratRegular(16)
        self.lblInstitute.font = UIFont.montserratRegular(16)
        self.lblStartsFrom.font = UIFont.montserratRegular(16)
        self.lblEndsTo.font = UIFont.montserratRegular(16)
        
        self.lblView.cornerRadius(16)
        
        self.startYearPicker.delegate = self
        self.endYearPicker.delegate = self
        self.txtStartsFrom.inputView = startYearPicker
        self.txtEndsTo.inputView = endYearPicker
    }
    
    func configure(data: AcademicsModel) {
        self.txtDegree.text = data.txtDegree
        self.txtInstitute.text = data.txtInstitute
        self.txtStartsFrom.text = data.txtStartsFrom
        self.txtEndsTo.text = data.txtEndsTo
    }
    
    //MARK: Configure PickerView for Year
    func configurePickerforStartYear() -> [String] {
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
    func configurePickerforEndYear() -> [String] {
        years = []
        let selectedYear = txtStartsFrom.text ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let date = formatter.date(from: selectedYear)!
        
        let startYear = Int(formatter.string(from: date)) ?? 0
        let currentYear = Int(formatter.string(from: Date())) ?? 0
        
        for loop in stride(from: currentYear, through: startYear, by: -1) {
            years.append("\(loop)")
        }
        return years
    }
    
    //MARK: IBACTION
    @IBAction func btnDeletePressed(_ sender: Any) {
        self.deleteCell?()
    }
}

//MARK: TextField Delegate
extension AcademicsTVCell: UITextViewDelegate {
    @objc private func textFieldDegreeDidChange(_ textField: UITextField) {
        self.textDegreeDidChange?(textField)
    }
    
    @objc private func textFieldInstituteDidChange(_ textField: UITextField) {
        self.textInstituteDidChange?(textField)
    }
}

//MARK: UIPickerView Methods
extension AcademicsTVCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == startYearPicker {
            return configurePickerforStartYear().count
        } else {
            if txtStartsFrom.text == "" {
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
            if txtStartsFrom.text == "" {
                return ""
            } else {
                return configurePickerforEndYear()[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == startYearPicker {
            txtStartsFrom.text = years[row]
            txtEndsTo.text = ""
            delegate?.dismissPicker()
            self.textStartDateDidChange?(txtStartsFrom)
        } else {
            txtEndsTo.text = configurePickerforEndYear()[row]
            delegate?.dismissPicker()
            self.textEndDateDidChange?(txtEndsTo)
        }
        
    }
}
