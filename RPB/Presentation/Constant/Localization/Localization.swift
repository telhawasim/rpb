//
//  Localization.swift
//  RPB
//
//  Created by Telha Wasim on 16/01/2023.
//

import Foundation

struct Localization {
    
    struct Login {
        static let kEmailEmptyError = NSLocalizedString("field_email_empty_error", comment: "Email Error")
        static let kEmailInvalidError = NSLocalizedString("field_email_valid_error", comment: "Email Valid Error")
        static let kEmailIncorrectError = NSLocalizedString("field_email_incorrect_error", comment: "Email Incorrect Error")
        static let kPasswordEmptyError = NSLocalizedString("field_password_empty_error", comment: "Password Error")
        static let kPasswordIncorrectError = NSLocalizedString("field_password_incorrect_error", comment: "Password Incorrect Error")
        static let kPasswordLengthError = NSLocalizedString("field_password_length_error", comment: "Password Length Error")
    }
    
    struct AddEmployee {
        static let kNameEmptyError = NSLocalizedString("field_name_empty_error", comment: "Name Error")
        static let kDesignationEmptyError = NSLocalizedString("field_designation_empty_error", comment: "Designation Error")
        static let kDepartmentEmptyError = NSLocalizedString("field_department_empty_error", comment: "Department Error")
        static let kDobEmptyError = NSLocalizedString("field_dob_empty_error", comment: "DOB Error")
        static let kPhoneEmptyError = NSLocalizedString("field_phone_empty_error", comment: "Phone Number Error")
        static let kPhoneValidationError = NSLocalizedString("field_phone_validation_error", comment: "Phone Number Validation Error")
        static let kPhoneLengthError = NSLocalizedString("field_phone_length_error", comment: "Phone Length Error")
        static let kDateOfJoiningEmptyError = NSLocalizedString("field_joining_empty_error", comment: "Joining Error")
        static let kEmployeeAgeError = NSLocalizedString("field_age_error", comment: "Age Error")
        static let kProfilePictureError = NSLocalizedString("field_profile_picture_empty_error", comment: "Profile Picture Error")
    }
    
    struct Employee {
        static let kSearch = NSLocalizedString("search_placeholder", comment: "Search")
    }
    
    struct ResumeCV {
        static let kLinkedInInvalidError = NSLocalizedString("field_linkedIn_valid_error", comment: "LinkedIN Valid Error")
        static let kGitInvalidError = NSLocalizedString("field_git_valid_error", comment: "Git Valid Error")
        static let kProjectInvalidLink = NSLocalizedString("field_project_link_valid_error", comment: "Project Valid Error")
    }
}
