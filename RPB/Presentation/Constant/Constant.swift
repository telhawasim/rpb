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
var experienceData = ["Title", "Employment Type", "Comapny Name", "Location", "Location Type"]
var tagsArray = ["Excellent Communication", "Excellent", "Wireframe", "Design system", "Prototyping", "Figma", "Figma"]
var months = ["January", "February", "March", "April", "May", "June", "July", "August", "Spetember", "Octuber", "November", "December"]
var employmentType = ["", "Full-Time", "Part-Time", "Contract", "Overseas", "Trainee"]
var locationType = ["", "On-Site", "Hybrid", "Remote"]
var dummyText = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy."

struct Section {
    var section: String!
    var rows: Int!
    var expanded: Bool!
    
    init(section: String!, rows: Int!, expanded: Bool!) {
        self.section = section
        self.rows = rows
        self.expanded = expanded
    }
}

struct TextFieldModel {
    var title: String
    var placeholder: String
    var textValue: String = ""
    var tag: Int = 0
    var capitalizationType: UITextAutocapitalizationType = .none
    
    static func getInfoTextFields() -> [TextFieldModel] {
        var textFields = [TextFieldModel]()
        textFields.append(TextFieldModel(title: "Name", placeholder: "Dawid", tag: 0, capitalizationType: .words))
        textFields.append(TextFieldModel(title: "Designation", placeholder: "UI/UX Designer", tag: 1, capitalizationType: .words))
        textFields.append(TextFieldModel(title: "Email Address", placeholder: "dawid.name@gmail.com", tag: 2))
        textFields.append(TextFieldModel(title: "Phone Number", placeholder: "03350438764", tag: 3))
        textFields.append(TextFieldModel(title: "Git / Bit Bucket", placeholder: "Dawid.name@bitbucket.org", tag: 4,  capitalizationType: .words))
        textFields.append(TextFieldModel(title: "LinkedIn", placeholder: "linkedin.com/dawid.name", tag: 5))
        textFields.append(TextFieldModel(title: "", placeholder: "", tag: 6))
        return textFields
    }
}

struct ExperienceModel {
    var companyName: String = "Company Name"
    var txtCompanyName: String = ""
    var startDate: String = "Starts From"
    var txtStartDate: String = ""
    var endDate: String = "Ends to"
    var txtEndDate: String = ""
    var txtView: String = ""
    
    static func getExperienceTextFields() -> [ExperienceModel] {
        var experienceFields = [ExperienceModel]()
        experienceFields.append(ExperienceModel(txtCompanyName: "Synavos", txtEndDate: "2012"))
        
        return experienceFields
    }
}

struct SkillsModel {
    var txtSkills: String = ""
    var txtPercentage: String = ""
    var slider: Float = 0.0
    
    static func getSkillsData() -> [SkillsModel] {
        var skillsData = [SkillsModel]()
        skillsData.append(SkillsModel())
        return skillsData
    }
}

struct AcademicsModel {
    var txtDegree: String = ""
    var txtInstitute: String = ""
    var txtStartsFrom: String = ""
    var txtEndsTo: String = ""
    
    static func getAcademicsTextFields() -> [AcademicsModel] {
        let academicsFields = [AcademicsModel]()
        return academicsFields
        
    }
}
