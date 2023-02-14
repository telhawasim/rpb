//
//  HomeModel.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

struct HomeModel {
    var profilePicture: String
    var name: String
    var designation: String
    var email: String
    
    static func getEmployeeData() -> [HomeModel] {
        var employeeData = [HomeModel]()
        employeeData.append(HomeModel(profilePicture: "Dawid", name: "Dawid", designation: "UI/UX Designer", email: "dawid.surname@gmail.com"))
        employeeData.append(HomeModel(profilePicture: "Justyn", name: "Justyn", designation: "iOS Developer", email: "justyn.surname@gmail.com"))
        employeeData.append(HomeModel(profilePicture: "Marcin", name: "Marcin", designation: "React Developer", email: "marcin.surname@gmail.com"))
        employeeData.append(HomeModel(profilePicture: "Nelly", name: "Nelly", designation: "Web Developer", email: "nelly.surname@gmail.com"))

        return employeeData
    }
}
