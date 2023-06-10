//
//  ResumeModel.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation

struct ResumeModel: Codable {
   
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var data: ProfileResponse?
}

struct ProfileResponse: Codable {
    var basicInfo: BasicInfo?
    var id: String?
    var employeeID: String?
    var profileName: String?
    var experiences: [Experience]?
    var skills: [SkillsResponse]?
    var certificates: [CertificatesResponse]?
    var academics: [AcademicsResponse]?
    var projects: [ProjectsResponse]?
    var createdAt: String?
    var updatedAt: String?
    var __v: Int?
    var profileStatus: String?
}

struct BasicInfo: Codable {
    var companyName: String?
    var designation: String?
    var email: String?
    var gitLink: String?
    var linkedLink: String?
    var basicInfoSummary: String?
}

struct Experience: Codable {
    var companyName: String?
    var startsFrom: String?
    var endsTo: String?
    var designation: String?
    var jobDescription: String?
    var experienceType: String?
    var _id: String?
}

struct SkillsResponse: Codable {
    var skillName: String?
    var skillScore: Int?
    var skillType: String?
    var _id: String?
}

struct CertificatesResponse: Codable {
    var certName: String?
    var certInstitute: String?
    var certStartsFrom: String?
    var certEndsTo: String?
    var _id: String?
}

struct AcademicsResponse: Codable {
    var academicDegreeName: String?
    var academicInstitute: String?
    var academicStartsFrom: String?
    var academicEndsTo: String?
    var _id: String?
}

struct AwardsAndHonorsResponse: Codable {
    var awardTitle: String?
    var awardDescription: String?
    var _id: String?
}

struct ProjectsResponse: Codable {
    var projectName: String?
    var projectType: String?
    var projectTechStack: String?
    var projectLink: String?
    var projectImage: String?
}
