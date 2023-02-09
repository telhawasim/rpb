//
//  UserService.swift
//  febys
//
//  Created by Waseem Nasir on 28/06/2021.
//

import Foundation
import UIKit

class UserService {
    static let shared = UserService()
    
    private init() { }
    
    func signIn(body info: [String: String], headers: [String: String] = [:], onComplete: @escaping ((Result<SignUpResponse, RpbError>) -> Void)) {
        
        let urlString = URLHelper.shared.getURLString(with: URI.Users.login.rawValue)
        NetworkManager.shared.sendRequest(method: .POST, urlString, body: info, headers: headers) { (data, response, error, request) in

            guard APIErrorHandler.shared.handleError(data: data, response: response, error: error, request: request, onComplete: onComplete) else {return}
            ResponseManager.shared.decode(data: data, response: response, error: error, onComplete: onComplete)
        }
    }
}
