//
//  Localization.swift
//  RPB
//
//  Created by Telha Wasim on 16/01/2023.
//

import Foundation

struct Localization {
    
    struct Login {
        static let emailEmptyError = NSLocalizedString("field_email_empty_error", comment: "Email Error")
        static let emailValidError = NSLocalizedString("field_email_valid_error", comment: "Email Valid Error")
        static let emailIncorrectError = NSLocalizedString("field_email_incorrect_error", comment: "Email Incorrect Error")
        static let passwordEmptyError = NSLocalizedString("field_password_empty_error", comment: "Password Error")
        static let passwordIncorrectError = NSLocalizedString("field_password_incorrect_error", comment: "Password Incorrect Error")
        static let passwordLengthError = NSLocalizedString("field_password_length_error", comment: "Password Length Error")
    }
    
    struct AddEmployee {
        static let nameError = NSLocalizedString("field_name_empty_error", comment: "Name Error")
        static let designationError = NSLocalizedString("field_designation_empty_error", comment: "Designation Error")
        static let departmentError = NSLocalizedString("field_department_empty_error", comment: "Department Error")
        static let dobError = NSLocalizedString("field_dob_empty_error", comment: "DOB Error")
        static let phoneError = NSLocalizedString("field_phone_empty_error", comment: "Phone Number Error")
        static let phoneLengthError = NSLocalizedString("field_phone_length_error", comment: "Phone Length Error")
        static let joiningError = NSLocalizedString("field_joining_empty_error", comment: "Joining Error")
        static let employeeAgeError = NSLocalizedString("field_age_error", comment: "Age Error")
    }
    
    struct Employee {
        static let search = NSLocalizedString("search_placeholder", comment: "Search")
    }
}
