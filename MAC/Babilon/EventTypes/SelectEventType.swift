//
//  SelectEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum SelectEventType {
    case profile
    case filters
    case cart
    case settings
    case favorites
    case product(name: String, id: any Identifiable)
    case index(QuantityEventType)
    case address
    case shipping
    case paymentMethod
    case size
    case color
    case quantity
    case textField(TextFieldEventType)
    
    var id: String {
        description.sha256()
    }
    
    var path: String {
        switch self {
        case .profile:
            return "selectUserProfile"
        case .filters:
            return "selectFilters"
        case .cart:
            return "selectFilters"
        case .settings:
            return "selectSettings"
        case .favorites:
            return "selectFavorites"
        case .product( _, _):
            return "selectProductByName"
        case .index(_):
            return "selectListIndex"
        case .address:
            return "selectAddress"
        case .shipping:
            return "selectShipping"
        case .paymentMethod:
            return "selectPaymentMethod"
        case .size:
            return "selectSize"
        case .color:
            return "selectColor"
        case .quantity:
            return "selectQuantity"
        case .textField(let textFieldEvent):
            return textFieldEvent.description
        }
    }
    
    var description: String {
        switch self {
        case .profile:
            return "Select profile."
        case .filters:
            return "Select filters."
        case .cart:
            return "Select car."
        case .settings:
            return "Select settings."
        case .favorites:
            return "Select favorites."
        case .product(name: let name, _):
            return "Select product named: \(name)."
        case .index(let index):
            return "Select item \(index.description)"
        case .address:
            return "Select address."
        case .shipping:
            return "Select shipping."
        case .paymentMethod:
            return "Select payment method."
        case .size:
            return "Select size."
        case .color:
            return "Select color."
        case .quantity:
            return "Select quantity."
        case .textField(let textFieldEvent):
            return textFieldEvent.description
        }
    }
    
}
