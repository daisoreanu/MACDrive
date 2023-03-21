//
//  ApiEndpoint.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

public typealias AuthToken = String

enum HttpSchema: String {
    case http
    case https
}

enum ApiMethod: String {
    case GET
    case POST
    case PUT
}

enum ApiHeaderKeys: String {
    case authorization = "Authorization"
    case accessToken = "x-access-token"
    case contentType = "Content-Type"
}

public typealias ApiHeaders = [String: String]

protocol ApiEndpoint {
    var path: String { get }
    var requestType: ApiMethod { get }
    var headers: ApiHeaders { get }
    var bodyParams: Encodable? { get }
}

extension ApiEndpoint {
    var host: String {
        return "api-dot-fir-firestore-d081b.uc.r.appspot.com/virtual-assistant-api/v1"
    }
    var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }
    
    var jsonEncoder: JSONEncoder {
        let jsonEncoder = JSONEncoder()
        return jsonEncoder
    }
}

extension ApiEndpoint {
    func createRequest(authToken: AuthToken? = nil) -> Result<URLRequest, ApiNetworkError> {
        var components =  URLComponents()
        components.scheme = HttpSchema.https.rawValue
        components.host = host
        components.path = path
        guard let url = components.url else {
            return .failure(ApiNetworkError.invalidURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        if let authToken = authToken {
            urlRequest.addValue(authToken, forHTTPHeaderField: ApiHeaderKeys.accessToken.rawValue)
        }
        
        if let encodableBody = bodyParams {
            do {
                urlRequest.httpBody = try jsonEncoder.encode(encodableBody)
            } catch {
                return .failure(ApiNetworkError.encodingError)
            }
        }
        return .success(urlRequest)
    }
}
