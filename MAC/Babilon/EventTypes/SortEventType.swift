//
//  SortEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum SortEventType {
    case priceAscending
    case priceDescending
    case discounted
    case newArrivals
    case mostPopular
    case reviewCount
    case reset
    
    var id: String {
        return description.sha256()
    }
    
    var path: String {
        return "sortByFilterName"
    }
    
    var description: String {
        switch self {
        case .priceAscending:
            return "Sort by: price ascending." //sort from the most expensive to the cheapest, ssort by price low to high
        case .priceDescending:
            return "Sort by: price descending."
        case .discounted:
            return "Sort by: discounted."
        case .newArrivals:
            return "Sort by: new arrivals."
        case .mostPopular:
            return "Sort by: most popular."
        case .reviewCount:
            return "Sort by: number of reviews."
        case .reset:
            return "Clear filters." //remove sorting option, delete option
        }
    }
}
