//
//  ResponseManager.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation

class ResponseManager {
    static let shared = ResponseManager()
    
    private init() {}
    
    func decode<T: Codable>(data: Data?, response: URLResponse?, error: Error?, onComplete: @escaping ((Result<T, RpbError>) -> Void)) {
        if let data = data {
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    onComplete(.success(response))
                }
            } catch let error {
                onComplete(.failure(RpbError.error(error.localizedDescription)))
                print(error)
            }
        }
    }
}
