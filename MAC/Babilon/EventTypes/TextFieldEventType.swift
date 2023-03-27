//
//  TextFieldEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum TextFieldEventType {
    case email
    case password
    case firstName
    case lastName
    case fullName
    case userName
    case phoneNumber
    case address
    case country
    case city
    case street
    case streetNumber
    case buildingNumber
    case floorNumber
    case description
    case comment
    case custom(String)
    
    var id: String {
        return description.sha256()
    }
    
    var path: String{
        return "textFieldSelection"
    }
    
    var description: String {
        switch self {
        case .email:
            return "Select email text field."
        case .password:
            return "Select password text field."
        case .firstName:
            return "Select first name text field."
        case .lastName:
            return "Select last name text field."
        case .fullName:
            return "Select full name text field."
        case .userName:
            return "Select user name text field."
        case .phoneNumber:
            return "Select phone number text field."
        case .address:
            return "Select address text field."
        case .country:
            return "Select country text field."
        case .city:
            return "Select city text field."
        case .street:
            return "Select street text field."
        case .streetNumber:
            return "Select street number text field."
        case .buildingNumber:
            return "Select building number text field."
        case .floorNumber:
            return "Select floor number text field."
        case .description:
            return "Select description text field."
        case .comment:
            return "Select comment text field."
        case .custom(let message):
            return "Select \(message) text field."
        }
    }
    
}
