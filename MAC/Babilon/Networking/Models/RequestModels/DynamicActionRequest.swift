//
//  DinamycActionRequest.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

// MARK: - DynamicAction
struct DynamicActionRequest: Codable {
    let userInput: UserInput
    let screenActions: [ScreenAction]
    
    enum CodingKeys: String, CodingKey {
        case userInput = "user_input"
        case screenActions = "screen_actions"
    }
}

// MARK: - ScreenAction
struct ScreenAction: Codable {
    let dynamicAction: String
    let actionDescription: String
    
    enum CodingKeys: String, CodingKey {
        case dynamicAction = "dynamic_action"
        case actionDescription = "action_description"
    }
}

// MARK: - UserInput
struct UserInput: Codable {
    let plainText: String
    let naturalLanguageInterpretation: NaturalLanguageInterpretation
    
    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
        case naturalLanguageInterpretation = "natural_language_interpretation"
    }
}

// MARK: - NaturalLanguageInterpretation
struct NaturalLanguageInterpretation: Codable { }
