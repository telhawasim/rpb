//
//  UITextField.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import Foundation
import UIKit

extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.tintColor = .appColor
        
        
        // iOS 14 and above
        if #available(iOS 15, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .inline
            datePicker.sizeToFit()
            datePicker.maximumDate = .now
        }
        self.inputView = datePicker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    func charactersLimit(num: Int) {
        if (self.text!.count > num) {
            self.deleteBackward()
        }
    }
}
