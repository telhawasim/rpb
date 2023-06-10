//
//  Login.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation
import SwiftUI

extension URI {
    enum Users: String {
        case login = "auth/login"
        case employeeDashboard = "employee/dashboard"
        case employeeListing = "employee"
        case uploadImage = "employee/uploadImage"
        case departments = "departments"
        case designations = "designations"
        case profileListing = "profile/employeeProfiles"
        case cloneProfile = "profile/cloneProfile"
        case profile = "profile/"
        case exportPDF = "export"
    }
}
