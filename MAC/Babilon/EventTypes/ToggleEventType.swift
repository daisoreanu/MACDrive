//
//  ToggleEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum ToggleEventType {
    case on(name: String, id: any Identifiable)
    case off(name: String, id: any Identifiable)
    
    var id: String {
        description.sha256()
    }
    
    var path: String {
        switch self {
        case .on(name: _, id: _):
            return "toggleOn"
        case .off(name: _, id: _):
            return "toggleOff"
        }
    }
    
    var description: String {
        switch self {
        case .on(name: let name, id: _):
            return "Turn on: \(name)"
        case .off(name: let name, id: _):
            return "Turn off: \(name)"
        }
    }
}
