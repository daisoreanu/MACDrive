//
//  DinamycEventResponse.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 27.03.2023.
//

import Foundation

struct DinamycEventResponse: Decodable {
    let userInput: UserInput
    let screenActions: [ScreenAction]

    enum CodingKeys: String, CodingKey {
        case userInput = "user_input"
        case screenActions = "screen_actions"
    }
}
