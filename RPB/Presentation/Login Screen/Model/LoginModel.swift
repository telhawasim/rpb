//
//  LoginModel.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation

struct LoginModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: User?
}

struct User: Codable {
    var access_token: String?
    
    func save() -> Bool {
        return User.saveProfile(self)
    }
    
    static func saveProfile(_ value: User?) -> Bool {
        let defaults = UserDefaults()
        if value == nil {
            defaults.set(nil, forKey: Constants.user)
            return defaults.synchronize()
        }
        do {
            let data = try JSONEncoder().encode(value)
            
            defaults.set(data, forKey: Constants.user)
            return defaults.synchronize()
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    static func fetch() -> User? {
        let userDefaults = UserDefaults()
        guard let data = userDefaults.data(forKey: Constants.user) else {
            return nil
        }
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    static func remove() {
        let userDefaults = UserDefaults()
        if (userDefaults.object(forKey: Constants.user) != nil) {
            userDefaults.removeObject(forKey: Constants.user)
        }
    }
}
