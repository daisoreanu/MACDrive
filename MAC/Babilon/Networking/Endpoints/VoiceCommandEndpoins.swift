//
//  VoiceCommandEndpoins.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

internal enum VoiceCommandEndpoins: ApiEndpoint {
    
    case dynamicCommandRequest(userInput: String, actions: [EventType])
    
    var path: String {
        switch self {
        case .dynamicCommandRequest:
            return "/virtual-assistant-api/v1/selectDynamicCommand"
        }
    }
    
    var headers: ApiHeaders {
        [ApiHeaderKeys.contentType.rawValue: "application/json",
        ApiHeaderKeys.accept.rawValue: "application/json"]
    }
    
    var requestType: ApiMethod {
        ApiMethod.POST
    }
    
    var bodyParams: Encodable? {
        switch self {
        case .dynamicCommandRequest(userInput: let userInput, actions: let actions):
            guard actions.count > 0 else {
                print("no action received")
                return nil
            }
            let userInput = UserInput(plainText: userInput, naturalLanguageInterpretation: NaturalLanguageInterpretation())
            var screenActions: [ScreenAction] = []
            for action in actions {
                let screenAction = ScreenAction(dynamicAction: action.path, actionDescription: action.description.lowercased())
                screenActions.append(screenAction)
            }
            let requestBody = DynamicActionRequest(userInput: userInput, screenActions: screenActions)
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(requestBody) {
                // save `encoded` somewhere\
                do {
                 let json = try JSONSerialization.jsonObject(with: encoded, options: []) as? [String: Any]
                  // appropriate error handling
                  print(json)
                } catch {
                    print(error.localizedDescription)
                }
                
//                do {
//                    let decoder = JSONDecoder()
//                    let products = try decoder.decode([String: AnyObject].self, from: encoded)
//
//                } catch {
//                    print(jsonData)
//                }
            }
            
            return DynamicActionRequest(userInput: userInput, screenActions: screenActions)
        }
    }
}
