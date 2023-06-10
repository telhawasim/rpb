//
//  ConfigurationManager.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation

class ConfigurationManager: NSObject {

    static var shared = ConfigurationManager()
    private override init() {
        
    }
    
    func infoForKey(_ key: ConfigurationKey) -> String {
        return (Bundle.main.infoDictionary?[key.rawValue] as? String)?
                .replacingOccurrences(of: "\\", with: "") ?? "https://"
     }
}

enum ConfigurationKey: String {
    case baseURL
}
