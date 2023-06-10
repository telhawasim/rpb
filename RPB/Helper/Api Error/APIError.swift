//
//  APIError.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation

struct APIError: Codable {
    let status: Int?
    let message: String?
    let errors: [Errors]?
}

struct Errors: Codable {
    let field: String?
    let error: String?

    enum CodingKeys: String, CodingKey {

        case field
        case error
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        field = try values.decodeIfPresent(String.self, forKey: .field)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}
