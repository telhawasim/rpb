//
//  UserService.swift
//  RPB
//
//  Created by Noman Akram on 02/02/2023.
//

import Foundation
import UIKit

class UserService {
    static let shared = UserService()
    
    init() { }
    
    func signIn(body info: [String: String], headers: [String: String] = [:], onComplete: @escaping ((Result<LoginModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.login.rawValue)
        NetworkManager.shared.sendRequest(method: .POST, urlString, body: info, headers: headers) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchEmployeeCount(params info: [String: String]=[:], onComplete: @escaping ((Result<HomeModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.employeeDashboard.rawValue)
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchEmployeeListing(params info: [String: String]=[:], onComplete: @escaping ((Result<EmployeeListingResponse, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.employeeListing.rawValue)
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchFilteredEmployeeListing(params info: [String: String]=[:], onComplete: @escaping ((Result<EmployeeListingResponse, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.employeeListing.rawValue)
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchEmployeeDetail(id: String, params info: [String: String]=[:], onComplete: @escaping ((Result<EmployeeDetail, RpbError>) -> Void)) {
        
        let urlString = "\(URLHelper.shared.getURLString(with: URI.Users.employeeListing.rawValue))/\(id)"
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchDepartments(params info: [String: String]=[:], onComplete: @escaping ((Result<DepartmentModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.departments.rawValue)
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchDesignations(params info: [String: String]=[:], onComplete: @escaping ((Result<DesignationModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.designations.rawValue)
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchProfileListing(params info: [String: String]=[:], onComplete: @escaping ((Result<ProfileListingResponse, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.profileListing.rawValue)
        
        NetworkManager.shared.sendGetRequest(urlString, params: info) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func fetchProfileDetail(id: String, onComplete: @escaping ((Result<ResumeResponse, RpbError>) -> Void)) {
        
        let urlString = "\(URLHelper.shared.getURLString(with: URI.Users.profile.rawValue))\(id)"
        
        NetworkManager.shared.sendGetRequest(urlString) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func cloneProfileDetail(body info: [String: String] = [:], headers: [String: String] = [:], onComplete: @escaping ((Result<ResumeModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.cloneProfile.rawValue)
        
        NetworkManager.shared.sendRequest(method: .POST, urlString, body: info, headers: headers) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func addEmployee(body info: [String: String] = [:], headers: [String: String] = [:], onComplete: @escaping ((Result<EmployeeResponse, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.employeeListing.rawValue)
        
        NetworkManager.shared.sendRequest(method: .POST, urlString, body: info, headers: headers) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func uploadProfileImage(with image: UIImage, parameters key: String, onComplete: @escaping ((Result<EmployeeImageModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.uploadImage.rawValue)
        NetworkManager.shared.requestNativeImageUpload(urlString, forKey: key, image: image) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func deleteProfile(id: String, body info: [String: String] = [:], params: [String: Any] = [:], onComplete: @escaping ((Result<EmptyResponse, RpbError>) -> Void)) {
        
        let urlString = "\(URLHelper.shared.getURLString(with: URI.Users.profile.rawValue))\(id)"
        
        NetworkManager.shared.sendRequest(method: .DELETE, urlString, body: info, params: params ) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func editProfile(id: String, onComplete: @escaping ((Result<ResumeResponse, RpbError>) -> Void)) {
        
        let urlString = "\(URLHelper.shared.getURLString(with: URI.Users.profile.rawValue))\(id)"
        
        NetworkManager.shared.sendGetRequest(urlString) { (data, response, error, request) in
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func updateProfile(id: String, body info: [String: Any] = [:], params: [String: Any] = [:], onComplete: @escaping ((Result<ResumeModel, RpbError>) -> Void)) {
        
        let urlString = "\(URLHelper.shared.getURLString(with: URI.Users.profile.rawValue))\(id)"
        
        NetworkManager.shared.sendRequest(method: .PUT, urlString, body: info, params: params ) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
    
    func exportPDF(body info: [String: Any], onComplete: @escaping ((Result<Data, RpbError>) -> Void)) {
        
        let urlString = (URLHelper.shared.getURLString(with: URI.Users.exportPDF.rawValue))
        
        NetworkManager.shared.sendRequest(method: .POST, urlString, body: info) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
//            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
            if let data = data {
                onComplete(.success(data))
            } else {
                if let error = error {
                    onComplete(.failure(RpbError.error(error.localizedDescription)))
                }
            }
        }
    }
    
    func addProfile(body info: [String: String], headers: [String: String] = [:], onComplete: @escaping ((Result<ProfileModel, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.profile.rawValue)
        NetworkManager.shared.sendRequest(method: .POST, urlString, body: info, headers: headers) { (data, response, error, request) in
            
            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
}
