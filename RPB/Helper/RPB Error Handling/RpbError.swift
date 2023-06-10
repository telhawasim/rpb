//
//  RpbError.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation

class APIErrorHandler {
    static let shared = APIErrorHandler()
    private init() {}
    
    func handleError<T: Codable>(data: Data?, response: URLResponse?, error: Error?, request: URLRequest?, onComplete: @escaping ((Result<T, RpbError>) -> Void)) -> Bool {
        if let error = error {
            onComplete(.failure(RpbError.error(error.localizedDescription)))
            return false
        }
        
        guard let res = response as? HTTPURLResponse else {onComplete(.failure(RpbError.error(Constants.SomethingWentWrong))); return false}
        
        switch res.statusCode {
        case 401:
            onComplete(.failure(RpbError.error(Constants.unAuthorized)))
            return false
            
        case 400:
            if let data = data, let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                onComplete(.failure(RpbError.error(apiError.errors?.first?.error ?? apiError.message ?? Constants.SomethingWentWrong)))
            } else {
                onComplete(.failure(RpbError.error(Constants.SomethingWentWrong)))
            }
            return false
        case 404:
            if let data = data, let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                onComplete(.failure(RpbError.error(apiError.errors?.first?.error ?? apiError.message ?? Constants.SomethingWentWrong)))
            } else {
                onComplete(.failure(RpbError.error(Constants.SomethingWentWrong)))
            }
            return false
        case 429:
            if let data = data, let _ = try? JSONDecoder().decode(APIError.self, from: data) {
                onComplete(.failure(RpbError.error(Constants.refreshError)))
            } else {
                onComplete(.failure(RpbError.error(Constants.refreshError)))
            }
            return false
//        case 403:
////            ResponseManager.shared.
//            TokenManager.shared.handleTokenExpiry(with: request, onComplete: onComplete)
//            return false
            
        case 502:
            onComplete(.failure(RpbError.error(Constants.SomethingWentWrong)))
            return false
        default:
            return true
        }
    }
}

enum RpbError: Error {
    case error(_ message: String)
}

extension RpbError {
    var localizedDescription: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}
