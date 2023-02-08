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

struct TextFieldModel {
    var title: String
    var placeholder: String
    var textValue: String = ""
    var tag: Int = 0
    var capitalizationType: UITextAutocapitalizationType = .none
    var keyboardType: UIKeyboardType = .default
    
    static func getInfoTextFields() -> [TextFieldModel] {
        var textFields = [TextFieldModel]()
        textFields.append(TextFieldModel(title: "Name", placeholder: "Dawid", tag: 0, capitalizationType: .words))
        textFields.append(TextFieldModel(title: "Designation", placeholder: "UI/UX Designer", tag: 1, capitalizationType: .words))
        textFields.append(TextFieldModel(title: "Email Address", placeholder: "dawid.name@gmail.com", tag: 2, keyboardType: .emailAddress))
        textFields.append(TextFieldModel(title: "Phone Number", placeholder: "03350438764", tag: 3, keyboardType: .numberPad))
        textFields.append(TextFieldModel(title: "Git / Bit Bucket", placeholder: "Dawid.name@bitbucket.org", tag: 4,  capitalizationType: .words))
        textFields.append(TextFieldModel(title: "LinkedIn", placeholder: "linkedin.com/dawid.name", tag: 5))
        textFields.append(TextFieldModel(title: "", placeholder: "", tag: 6))
        return textFields
    }
}

struct ReadMoreModel {
    var tag: Int
    var isExpanded: Bool = false
    var description: String
    var perviousCompany: String

    static func getTags() -> [ReadMoreModel] {
        var buttonTag = [ReadMoreModel]()
        buttonTag.append(ReadMoreModel(tag: 1,description: "Summary", perviousCompany: ""))
        buttonTag.append(ReadMoreModel(tag: 2,description: "IOS Developer", perviousCompany: "Synavos"))
        buttonTag.append(ReadMoreModel(tag: 3,description: "IOS Developer", perviousCompany: "i2c"))
        buttonTag.append(ReadMoreModel(tag: 4,description: "IOS Developer", perviousCompany: "Pure Logics"))
        return buttonTag
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
