//
//  EditEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum EditEventType {
    case product
    case quantity
    case billing
    case shipping
    case favorites
    case comment
    case rating
    case profile
    case cart
    
    var id: String {
        return description.sha256()
    }
    
    var path: String {
        switch self {
        case .product:
            return "editProducts"
        case .quantity:
            return "editQuantity"
        case .billing:
            return "editBilling"
        case .shipping:
            return "editShipping"
        case .favorites:
            return "editFavorites"
        case .comment:
            return "editComment"
        case .rating:
            return "editRate"
        case .profile:
            return "editProfile"
        case .cart:
            return "editCart"
        }
    }
    
    var description: String {
        switch self {
        case .product:
            return "Edit cart"
        case .quantity:
            return "Edit quantity"
        case .billing:
            return "Edit billing"
        case .shipping:
            return "Edit shipping"
        case .favorites:
            return "Edit favorited"
        case .comment:
            return "Edit comment"
        case .rating:
            return "Edit rating"
        case .profile:
            return "Edit profile"
        case .cart:
            return "Edit cart"
        }
    }
}
