//
//  AddEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum AddEventType: Identifiable {
    case productToCart
    case quantity
    case billing
    case shipping
    case favorites
    case comment
    case rating
    
    var id: String {
        return path.sha256()
    }
    
    var path: String {
        switch self {
        case .productToCart:
            return "addProductToCart"
        case .quantity:
            return "addQuantity"
        case .billing:
            return "addBilling"
        case .shipping:
            return "addShipping"
        case .favorites:
            return "addToFavorites"
        case .comment:
            return "addComment"
        case .rating:
            return "addRate"
        }
    }
    
    var description: String {
        switch self {
        case .productToCart:
            return "Add product to cart"
        case .quantity:
            return "Add quantity"
        case .billing:
            return "Add billing"
        case .shipping:
            return "Add shipping"
        case .favorites:
            return "Add to favorited"
        case .comment:
            return "Add comment"
        case .rating:
            return "Add rating"
        }
    }
}
