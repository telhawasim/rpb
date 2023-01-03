//
//  DobTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 27/12/2022.
//

import UIKit

class DobTVCell: UITableViewCell {
    //MARK: Outlet
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtDate: UITextField!
    
    //MARK: Variables
    var delegate: ExperienceTVCellProtocol?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFont()
        self.configurePicker()
    }
    
    func configureFont() {
        self.lblDate.font = UIFont.montserratRegular(16)
    }
    
    func configurePicker() {
        self.txtDate.setInputViewDatePicker(target: self, selector: #selector(tapDoneDOB))

    }
    
    @objc func tapDoneDOB() {
        if let datePicker = self.txtDate.inputView as? UIDatePicker {
            var date = Date()
            date = datePicker.date
            if date.is18Plus() {
                self.txtDate.text = date.getFormattedDate(format: "dd-MM-yy")
            } else {
                self.txtDate.text = nil
                let errorMessage = "Employee must be 18+"
                delegate?.showAlert(errorMessage: errorMessage)
            }
        }
        self.txtDate.resignFirstResponder()
    }
}
