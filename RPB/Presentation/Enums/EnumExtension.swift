//
//  EnumExtension.swift
//  RPB
//
//  Created by Bilal Nisar on 30/12/2022.
//

import Foundation
import UIKit

enum Category: String, CaseIterable {
    case info = "Info"
    case experience = "Experience"
    case skills = "Skills"
    case academics = "Academics"
    case projects = "Projects"
}

enum CellType {
    case experince
    case skills
    case certificates
    case academic
    case projects
    case awards
}

enum ValidationType {
    case info
    case experience
    case technicalSkills
    case nonTechnicalSkills
    case tools
    case certificates
    case academics
    case awards
    case projects
}

enum TabbarType {
    case home
    case employees
    case logout
}

enum PopupType {
    case discardInformation
    case deleteProfile
}

enum EmptyScreenType {
    case previousExperience
    case certificates
    case employeeListing
    case awards
    case technicalSkills
    case nonTechicalSkills
    case tools
    case projects
}

enum ProjectsCellType {
    case empty
    case addMore
    case addProjects
}

enum DefaultValue {
    static let string = ""
    static let float: Float = 0.0
    static let double: Double = 0.0
    static let cgfloat: CGFloat = 0.0
    static let bool: Bool = false
    static let int: Int = 0
    static let space = " "
    static let comma = ", "
    static let date: Date = Date()
    static let dateFormat = "MM/dd/yyyy"
    static let timeInterval = TimeInterval(00.00)
    static let notSet = "not set"
    static let errorMessage = "Something went wrong."
}
