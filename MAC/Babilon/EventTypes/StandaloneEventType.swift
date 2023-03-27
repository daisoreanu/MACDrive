//
//  StandaloneEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum StandaloneEventType {
    case startScrolling
    case stopScrolling
    case scrollUp
    case startScrollLeft
    case startScrollRight
    case goBack
    case save
    case confirm
    case logIn(AuthEventType)
    case signUp(AuthEventType)
    case logOut
    case share
    case showMore
    case showLess
    
    var id: String {
        return description.sha256()
    }
    
    var path: String {
        switch self {
        case .startScrolling:
            fallthrough
        case .stopScrolling:
            fallthrough
        case .scrollUp:
            fallthrough
        case .startScrollLeft:
            fallthrough
        case .startScrollRight:
            return "scrollEvents"
        case .goBack:
            return "goBack"
        case .save:
            return "saveAction"
        case .confirm:
            return "confirmAction"
        case .logIn(_):
            fallthrough
        case .signUp(_):
            fallthrough
        case .logOut:
            return "authentication"
        case .share:
            return "share"
        case .showMore:
            fallthrough
        case .showLess:
            return "expandAction"
        }
    }
    
    var description: String {
        switch self {
        case .startScrolling:
            return "Start scrolling"
        case .stopScrolling:
            return "Stop scrolling"
        case .scrollUp:
            return "Start scroll up"
        case .startScrollLeft:
            return "Start scrolling left"
        case .startScrollRight:
            return "Start scrolling right"
        case .goBack:
            return "Go back"
        case .save:
            return "Save"
        case .confirm:
            return "Confirm"
        case .logIn(let authType):
            switch authType {
            case .email:
                return "Log in with email address"
            case .facebook:
                return "Log in with Facebook"
            case .gmail:
                return "Log in with Gmail"
            case .phoneNumber:
                return "Log in with phone number"
            }
        case .signUp(let authType):
            switch authType {
            case .email:
                return "Sign up with email address"
            case .facebook:
                return "Sign up with Facebook"
            case .gmail:
                return "Sign up with Gmail"
            case .phoneNumber:
                return "Sign up with phone number"
            }
        case .logOut:
            return "Log out"
        case .share:
            return "Share"
        case .showMore:
            return "Show more"
        case .showLess:
            return "Show less"
        }
    }
}
