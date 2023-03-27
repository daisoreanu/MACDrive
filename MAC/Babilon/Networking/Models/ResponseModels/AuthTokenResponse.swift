//
//  AuthTokenResponse.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 27.03.2023.
//

import Foundation

struct AuthTokenResponse: Decodable {
    var apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}

