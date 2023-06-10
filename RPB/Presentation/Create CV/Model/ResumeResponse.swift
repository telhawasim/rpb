//
//  ResumeResponse.swift
//  RPB
//
//  Created by Telha Wasim on 30/03/2023.
//

import Foundation

struct ResumeResponse: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var data: ProfileDetail?
}

struct ProfileDetail: Codable {
    var id, employeeID, profileName: String?
    var experiences: [Experience]?
    var skills: [SkillsResponse]?
    var certificates: [CertificatesResponse]?
    var academics: [AcademicsResponse]?
    var awardsAndHonors: [AwardsAndHonorsResponse]?
    var projects: [ProjectsResponse]?
    var createdAt, updatedAt: String?
    var v: Int?
    var basicInfo: BasicInfoResponse?
    var profileStatus: String?
    var profilePicture: String?
}

struct BasicInfoResponse: Codable {
    var email: String?
    var designation: Departments?
    var phone, linkedLink, basicInfoSummary, companyName: String?
    var gitLink: String?
}
