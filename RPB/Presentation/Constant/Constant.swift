//
//  Constant.swift
//  RPB
//
//  Created by Bilal Nisar on 30/12/2022.
//

@_exported import UIKit
@_exported import Foundation
@_exported import AVKit

var infoData = ["Name", "Designation", "Date of Birth", "Email Address", "Phone Number"]
var infoPlaceholder = ["Dawid", "iOS Developer", "07-08-99", "dawid.name@gmail.com", "03350438764"]
var educationData = ["School / University", "Degree", "Field of Study"]
var educationPlaceholder = ["Virtual University", "Master's Degree", "BIT"]
var experienceData = ["Title", "Employment Type", "Comapny Name","Location","Location Type"]
var tagsArray = ["Excellent Communication","Excellent","Wireframe","Design system","Prototyping","Figma","Figma"]

struct Section {
    var section: String!
    var rows: [Int]!
    var expanded: Bool!
    
    init(section: String!, rows: [Int], expanded: Bool!) {
        self.section = section
        self.rows = rows
        self.expanded = expanded
    }
}
