//
//  PickEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

//used on picker screens
enum PickEventType {
    case shippingType(name: String, id: any Identifiable)
    case paymentMethod(PaymetEventType)
    case shippingAddress(name: String, id: any Identifiable)
    case billingAddress(name: String, id: any Identifiable)
    case color(name: String, id: any Identifiable)
    case quantity(QuantityEventType)
    
    var id: String {
        return description.sha256()
    }
    
    var path: String {
        switch self {
        case .shippingType(name: _, id: _):
            return "shippingTypePicker"
        case .paymentMethod(_):
            return "paymentMethodPicker"
        case .shippingAddress(name: _, id: _):
            return "shippingAddressPicker"
        case .billingAddress(name: _, id: _):
            return "billingAddressPicker"
        case .color(name: _, id: _):
            return "colorPicker"
        case .quantity(_):
            return "quantityPicker"
        }
    }
    
    var description: String {
        switch self {
        case .shippingType(name: let name, id: _):
            return "Select shipping option named: \(name)"
        case .paymentMethod(let paymentType):
            switch paymentType {
            case .creditCard:
                return "Select credit card as payment method."
            case .debitCard:
                return "Select debit card as payment method."
            case .applePay:
                return "Select Apple Pay as payment method."
            case .virtualCurrrency:
                return "Select virtual currency as payment method."
            case .loyaltyPoints:
                return "Select loyalty points as payment method."
            }
        case .shippingAddress(name: let name, id: _):
            return "\(name) shipping address"
        case .billingAddress(name: let name, id: _):
            return "\(name) billing address"
        case .color(name: let name, id: _):
            return "Slect color named: \(name)"
        case .quantity(let quantity):
            return "Select \(quantity.description)"
        }
    }
}
