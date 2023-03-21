//
//  VoiceCommandEndpoins.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

internal enum VoiceCommandEndpoins: ApiEndpoint {
    
    case defaultCommandRequest
    case dynamicCommandRequest
    
    var path: String {
        switch self {
        case .defaultCommandRequest:
            return "/selectDefaultCommand"
        case .dynamicCommandRequest:
            return "/selectDynamicCommand"
        }
    }
    
    var headers: ApiHeaders {
        [ApiHeaderKeys.contentType.rawValue: "application/json"]
    }
    
    var requestType: ApiMethod {
        ApiMethod.POST
    }
    
    var bodyParams: Encodable? {
        switch self {
        case .defaultCommandRequest:
            return nil
        case .dynamicCommandRequest:
            return nil
        }
    }
    
    
}
