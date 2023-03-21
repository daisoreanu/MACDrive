//
//  DynamicCommand.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

enum DynamicCommand {
    
    case sortByFiltersName(filterName: String)
    case selectQuantity(qty: String)
    case filterByCategory(category: String)
    case filterBySubcategory(subcategory: String)
    case removeProductByName(productName: String)
    case selectProductByName(productName: String)
    
    var dynamicAction: String {
        switch self {
        case .sortByFiltersName(filterName: _):
            return "sortByFiltersName"
        case .selectQuantity(qty: _):
            return "selectQuantity"
        case .filterByCategory(category: _):
            return "filterByCategory"
        case .filterBySubcategory(subcategory: _):
            return "filterBySubcategory"
        case .removeProductByName(productName: _):
            return "removeProductByName"
        case .selectProductByName(productName: _):
            return "selectProductByName"
        }
    }
    
    var actionDescription: String {
        switch self {
        case .sortByFiltersName(filterName: let filterName):
            return "Sort by \(filterName)"
        case .selectQuantity(qty: let qty):
            return "Select quantity \(qty)"
        case .filterByCategory(category: let category):
            return "Filter by category \(category)"
        case .filterBySubcategory(subcategory: let subcategory):
            return "Filter by subcategory \(subcategory)"
        case .removeProductByName(productName: let productName):
            return "Remove product \(productName)"
        case .selectProductByName(productName: let productName):
            return "Select product \(productName)"
        }
    }
    
}
