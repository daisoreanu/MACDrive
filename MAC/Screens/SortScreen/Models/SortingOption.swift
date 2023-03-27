//
//  SortingOptions.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import Foundation

enum SortingOption: CaseIterable {
    
    case newArrivals
    case bestSeller
    case highestPriceFirst
    case lowestPriceFirst
    
    var text: String {
        switch self {
        case .newArrivals:
            return "New Arrivals"
        case .bestSeller:
            return "Best Seller"
        case .highestPriceFirst:
            return "Highest Price First"
        case .lowestPriceFirst:
            return "Lowest Price First"
        }
    }
    
}
