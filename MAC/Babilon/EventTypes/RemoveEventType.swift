//
//  RemoveEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum RemoveEventType {
    case product
    case quantity
    case billing
    case shipping
    case favorites
    case comment
    case rating
    case cart
    
    var id: String {
        return description.sha256()
    }
    
    var path: String {
        switch self {
        case .product:
            return "removeProducts"
        case .quantity:
            return "removeQuantity"
        case .billing:
            return "removeBilling"
        case .shipping:
            return "removeShipping"
        case .favorites:
            return "removeFavorites"
        case .comment:
            return "removeComment"
        case .rating:
            return "removeRate"
        case .cart:
            return "removeFromCart"
        }
    }
    
    var description: String {
        switch self {
        case .product:
            return "Remove product"
        case .quantity:
            return "Reset quantity"
        case .billing:
            return "Remove billing"
        case .shipping:
            return "Remove shipping"
        case .favorites:
            return "Remove from favorited"
        case .comment:
            return "Remove comment"
        case .rating:
            return "Remove rating"
        case .cart:
            return "Empty cart"
        }
    }
}
