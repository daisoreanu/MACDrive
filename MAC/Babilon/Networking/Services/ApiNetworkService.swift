//
//  ApiNetworkService.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 27.03.2023.
//

import Foundation

protocol ApiNetworkServiceProtocol: AnyObject {
    @discardableResult
    func perform(requestWith endpoint: ApiEndpoint,
                 authToken: AuthToken?,
                 completion: @escaping (Result<Data, ApiNetworkError>) -> Void) -> URLSessionDataTask?
}

class ApiNetworkService: ApiNetworkServiceProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(requestWith endpoint: ApiEndpoint,
                 authToken: AuthToken? = nil,
                 completion: @escaping (Result<Data, ApiNetworkError>) -> Void) -> URLSessionDataTask? {
        switch endpoint.stubBehavior {
        case .never:
            return performNetworkCall(endpoint, authToken, completion)
        case .immediate:
            completion(endpoint.sampleData)
            return nil
        case .delayed(seconds: let seconds):
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                completion(endpoint.sampleData)
            }
            return nil
        }
    }
    
}

private extension ApiNetworkService {
    func performNetworkCall(_ endpoint: ApiEndpoint,
                            _ authToken: AuthToken?,
                            _ completion: @escaping (Result<Data, ApiNetworkError>) -> Void) -> URLSessionDataTask? {
        let result = endpoint.createRequest(authToken: authToken)
        switch result {
        case .success(let request):
            let task = urlSession.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.responseWithStatusCode(-1)))
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    completion(.failure(.responseWithStatusCode(httpResponse.statusCode)))
                    return
                }
                guard let data = data else {
                    completion(.failure(.missingData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
            return task
        case .failure(let error):
            completion(.failure(error))
            return nil
        }
    }
}

