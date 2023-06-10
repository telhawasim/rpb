//
//  Constant.swift
//  RPB
//
//  Created by Bilal Nisar on 30/12/2022.
//

@_exported import UIKit
@_exported import Foundation
@_exported import AVKit

struct TextFieldModel: Codable {
    var title: String
    var placeholder: String
    var textValue: String = ""
    var tag: Int = 0
    var capitalizationType: Int = UITextAutocapitalizationType.none.rawValue
    var keyboardType: Int = UIKeyboardType.default.rawValue
    var isAsterisk: Bool = false
    var isDropDown: Bool = true
    
    static func getInfoTextFields() -> [TextFieldModel] {
        var textFields = [TextFieldModel]()
        textFields.append(TextFieldModel(title: "Name", placeholder: "Enter name", tag: 0, capitalizationType: UITextAutocapitalizationType.words.rawValue, isAsterisk: true))
        textFields.append(TextFieldModel(title: "Designation", placeholder: "Select designation", tag: 1, capitalizationType: UITextAutocapitalizationType.words.rawValue, isAsterisk: true, isDropDown: false))
        textFields.append(TextFieldModel(title: "Email Address", placeholder: "Enter email address", tag: 2, keyboardType: UIKeyboardType.emailAddress.rawValue, isAsterisk: true))
        textFields.append(TextFieldModel(title: "Phone Number", placeholder: "Enter phone number", tag: 3, keyboardType: UIKeyboardType.numberPad.rawValue, isAsterisk: true))
        textFields.append(TextFieldModel(title: "Git / Bit Bucket", placeholder: "Enter git/bit bucket url", tag: 4))
        textFields.append(TextFieldModel(title: "LinkedIn", placeholder: "Enter linkedin url", tag: 5))
        textFields.append(TextFieldModel(title: "", placeholder: "", tag: 6, keyboardType: UIKeyboardType.emailAddress.rawValue))
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
        buttonTag.append(ReadMoreModel(tag: 0,description: "Summary", perviousCompany: ""))
        return buttonTag
    }
}

struct ExperienceModel: Codable {
    var companyName: String
    var startsFrom: String
    var endsTo: String
    var designation: String
    var jobDescription: String
    var experienceType: String
    
    init(companyName: String, startsFrom: String, endsTo: String, designation: String, jobDescription: String, experienceType: String = "past") {
        self.companyName = companyName
        self.startsFrom = startsFrom
        self.endsTo = endsTo
        self.designation = designation
        self.jobDescription = jobDescription
        self.experienceType = experienceType
    }
    
    static func getExperienceTextFields() -> [ExperienceModel] {
        var experienceFields = [ExperienceModel]()
        experienceFields.append(ExperienceModel(companyName: StringConstants.synavosSolutions, startsFrom: "", endsTo: "Mar 2023", designation: "", jobDescription: "", experienceType: "current"))
        return experienceFields
    }
}

struct SkillsModel: Codable {
    var skillName: String
    var skillScore: Int
    var skillType: String
    
    init(skillName: String, skillScore: Int, skillType: String) {
        self.skillName = skillName
        self.skillScore = skillScore
        self.skillType = skillType
    }

    static func getTechnicalSkillsData() -> [SkillsModel] {
        let technicalSkillsData = [SkillsModel]()

        return technicalSkillsData
    }
    
    static func getNonTechnicalSkills() -> [SkillsModel] {
        let nonTechnicalSkills = [SkillsModel]()

        return nonTechnicalSkills
    }
    
    static func getTools() -> [SkillsModel] {
        let toolsData = [SkillsModel]()

        return toolsData
    }
}

struct CertificatesModel: Codable {
    var certName: String
    var certInstitute: String
    var certStartsFrom: String
    var certEndsTo: String
    
    init(certName: String, certInstitute: String, certStartsFrom: String, certEndsTo: String) {
        self.certName = certName
        self.certInstitute = certInstitute
        self.certStartsFrom = certStartsFrom
        self.certEndsTo = certEndsTo
    }
    
    static func getCertificateTextFields() -> [CertificatesModel] {
        let certificateFields = [CertificatesModel]()
        return certificateFields
    }
}

struct AcademicsModel: Codable {
    var academicDegreeName: String
    var academicInstitute: String
    var academicStartsFrom: String
    var academicEndsTo: String
    
    init(academicDegreeName: String, academicInstitute: String, academicStartsFrom: String, academicEndsTo: String) {
        self.academicDegreeName = academicDegreeName
        self.academicInstitute = academicInstitute
        self.academicStartsFrom = academicStartsFrom
        self.academicEndsTo = academicEndsTo
    }
    
    static func getAcademicsTextFields() -> [AcademicsModel] {
        var academicsFields = [AcademicsModel]()
        academicsFields.append(AcademicsModel(academicDegreeName: "", academicInstitute: "", academicStartsFrom: "", academicEndsTo: ""))

        return academicsFields
        
    }
}

struct AwardsModel: Codable {
    var awardTitle: String
    var awardDescription: String
    
    init(awardTitle: String, awardDescription: String) {
        self.awardTitle = awardTitle
        self.awardDescription = awardDescription
    }
    
    static func getAwardsTextFields() -> [AwardsModel] {
        let awardsFields = [AwardsModel]()
        return awardsFields
    }
}

struct ProjectsModel: Codable {
    var projectName: String
    var projectType: String
    var projectTechStack: String
    var projectLink: String
    var projectImage: String
    
    init(projectName: String, projectType: String, projectTechStack: String, projectLink: String, projectImage: String) {
        self.projectName = projectName
        self.projectType = projectType
        self.projectTechStack = projectTechStack
        self.projectLink = projectLink
        self.projectImage = projectImage
    }
    
    static func getProjectsTextFields() -> [ProjectsModel] {
        let projectsFields = [ProjectsModel]()
        return projectsFields
    }
}
