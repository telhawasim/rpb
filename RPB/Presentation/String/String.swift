//
//  String.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import Foundation
import UIKit
import PhoneNumberKit

extension String {
    
    func isEmailValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@(?=.{2,}\\.[^.]*$)[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    func isValidUrl() -> Bool {
        let urlRegEx = "((http|https|ftp)://)?([a-zA-Z0-9]+([a-zA-Z0-9-]*[a-zA-Z0-9]+)?\\.)+[a-zA-Z]{2,}(\\/\\S*)?"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: self)
        return result
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func convertToDate(format: String = DateFormat.dateFormatyyyMMddTZHHmmss) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date ?? nil
    }
    
    func convertDate(from: String, to: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = to
        return dateFormatter.string(from: date)
    }
    
    func convertDateToMMM_YYYY() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = DateFormat.yyyy_mm_dd
        
        guard let date = dateFormatterGet.date(from: self) else { return nil }
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = DateFormat.MMM_yyyy
        
        return dateFormatterPrint.string(from: date)
    }
    
    func formatPhoneNumberWithHyphen() -> String {
        let phoneNumberKit = PhoneNumberKit()
        
        do {
            let phoneNumber = try phoneNumberKit.parse(self)
            let countryCode = phoneNumberKit.countryCode(for: phoneNumber.regionID ?? "")
            let nationalNumber = phoneNumber.nationalNumber
            
            let modifiedPhoneNumber = "+\(countryCode ?? 0)-\(nationalNumber)"
            
            return modifiedPhoneNumber
        } catch {
            print("Error parsing phone number: \(error)")
            return self
        }
    }
}
