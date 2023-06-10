//
//  ProfileModel.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation

struct ProfileModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: Profile?
}

struct Profile: Codable {
    var _id: String?
    var profileName: String?
    
    enum CodingKeys: String, CodingKey {
        case _id
        case profileName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        profileName = try values.decodeIfPresent(String.self, forKey: .profileName)
    }
}

struct ProfileListingResponse: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let data: [ProfileListing]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case statusCode = "statusCode"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([ProfileListing].self, forKey: .data)
    }
}

struct ProfileListing: Codable {
    let basicInfo: BasicInfoResponse?
    let id: String?
    let employeeId: String?
    let profileName: String?
    let experiences: [Experience]?
    let skills: [SkillsResponse]?
    let certificates: [CertificatesResponse]?
    let academics: [AcademicsResponse]?
    let createdAt: String?
    let updatedAt: String?
    let profileStatus: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {

        case basicInfo = "basicInfo"
        case id = "_id"
        case employeeId = "employeeId"
        case profileName = "profileName"
        case experiences = "experiences"
        case skills = "skills"
        case certificates = "certificates"
        case academics = "academics"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case profileStatus = "profileStatus"
        case v = "v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        basicInfo = try values.decodeIfPresent(BasicInfoResponse.self, forKey: .basicInfo)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        profileName = try values.decodeIfPresent(String.self, forKey: .profileName)
        experiences = try values.decodeIfPresent([Experience].self, forKey: .experiences)
        skills = try values.decodeIfPresent([SkillsResponse].self, forKey: .skills)
        certificates = try values.decodeIfPresent([CertificatesResponse].self, forKey: .certificates)
        academics = try values.decodeIfPresent([AcademicsResponse].self, forKey: .academics)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        profileStatus = try values.decodeIfPresent(String.self, forKey: .profileStatus)
        v = try values.decodeIfPresent(Int.self, forKey: .v)
    }
}
