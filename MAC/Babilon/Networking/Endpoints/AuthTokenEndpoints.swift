//
//  AuthTokenEndpoints.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 27.03.2023.
//

import Foundation

internal enum AuthTokenEndpoints: ApiEndpoint {

    case getAuthToken
    
    var path: String {
        #warning("to be implemented")
        return ""
    }
    
    var headers: ApiHeaders {
        let username = ""
        let password = ""
        let credentials = Data("\(username):\(password)".utf8).base64EncodedString()
        return [ApiHeaderKeys.authorization.rawValue: credentials]
    }
    
    var requestType: ApiMethod {
        ApiMethod.GET
    }
    
    var bodyParams: Encodable? { return nil }
    
    var sampleData: Result<Data, ApiNetworkError> { .success(Data()) }
    var stubBehavior: StubBehavior {.never}
    
}
