//
//  EnumExtension.swift
//  RPB
//
//  Created by Bilal Nisar on 30/12/2022.
//

import Foundation
import UIKit

enum InfoType {
    case info
    case skills
    case experience
}

enum Category: String, CaseIterable {
    case info = "Info"
    case experience = "Experience"
    case skills = "Skills"
    case academics = "Academics"
}
