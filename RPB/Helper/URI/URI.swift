//
//  URI.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation

struct URI: Codable {
    private init() { }
    
}

class URLHelper {
    static let shared = URLHelper()
    private let baseURL = ConfigurationManager.shared.infoForKey(.baseURL)
    
    func getURLString(with url: String) -> String {
        return baseURL + url
    }
}
