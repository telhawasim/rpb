//
//  AddEmployeeModel.swift
//  RPB
//
//  Created by Telha Wasim on 31/01/2023.
//

import Foundation

struct DepartmentModel: Codable {
    let departments: [Departments]?
}

struct DesignationModel: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var data: DesignationResponse?
}

struct DesignationResponse: Codable {
    var designations: [Departments]
}

struct Departments: Codable {
    var _id: String?
    var title: String?
}
