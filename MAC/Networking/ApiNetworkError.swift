//
//  ApiNetworkError.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

enum ApiNetworkError: LocalizedError {
    case invalidURL
    case responseWithStatusCode(Int)
    case invalidAuthToken
    case decodingError
    case encodingError
    case missingData
    case noInternetConnection
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Wrong URL components"
        case .responseWithStatusCode(let statusCode):
            return "Request failed with HTTP status code \(statusCode)"
        case .invalidAuthToken:
            return "Invalid authentication token"
        case .decodingError:
            return "Failed to parse network response"
        case .encodingError:
            return "Failed to encode data"
        case .missingData:
            return "Network resul is missing data"
        case .noInternetConnection:
            return "No internet connection"
        }
    }
}
