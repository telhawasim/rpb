//
//  EmployeeImageModel.swift
//  RPB
//
//  Created by Synavos on 28/03/2023.
//

import Foundation

struct EmployeeImageModel: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let data: ProfileURL?

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
        data = try values.decodeIfPresent(ProfileURL.self, forKey: .data)
    }
}

struct ProfileURL: Codable {
    let url: String?

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
