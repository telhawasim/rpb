//
//  String.swift
//  RPB
//
//  Created by Telha Wasim on 23/12/2022.
//

import Foundation
import UIKit

extension String {

    func isEmailValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@(?=.{2,}\\.[^.]*$)[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    func isLinkedInValid() -> Bool {
        let linkedInRegex = "linkedin.com/in/[a-zA-Z0-9]+"
        let linkedInTest = NSPredicate(format: "SELF MATCHES %@", linkedInRegex)
        let result = linkedInTest.evaluate(with: self)
        return result
    }
}
