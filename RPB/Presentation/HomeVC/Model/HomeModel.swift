//
//  HomeModel.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

struct HomeModel: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: EmployeeStats?
}

struct EmployeeStats: Codable {
    let totalEmployees: Int?
    let createdProfiles: Int?
    let pendingProfiles: Int?

}

struct EmployeeListingResponse: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    var data: Employees?
}

struct Employees: Codable {
    var employees: [EmployeeListing]?
    var totalPages, currentPage: Int?
}

struct EmployeeListing: Codable {
    let _id: String?
    let profilePicture: String?
    let name: String?
    let designation: Departments?
    let department: Departments?
    let dateOfBirth: String?
    let email: String?
    let phone: String?
    let dateOfJoining: String?
    let createdAt: String?
    let updatedAt: String?
}

struct EmployeeDetail: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: EmployeeListing?
}

struct Department: Codable {
    let title: String?
}

struct EmployeeResponse: Codable {
    let statusCode: Int?
    let status: Bool?
    let message: String?
    let data: EmployeeSingleResponse?
}

struct EmployeeSingleResponse: Codable {
    let _id: String?
    let profilePicture: String?
    let name: String?
    let designation: String?
    let department: String?
    let dateOfBirth: String?
    let email: String?
    let phone: String?
    let dateOfJoining: String?
    let createdAt: String?
    let updatedAt: String?
}
