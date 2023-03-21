//
//  DefaultActionRequest.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

// MARK: - DefaultAction
struct DefaultAction: Codable {
    let userInput: UserInput
    let screenActions: [String]

    enum CodingKeys: String, CodingKey {
        case userInput = "user_input"
        case screenActions = "screen_actions"
    }
}

