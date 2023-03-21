//
//  Product.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import Foundation

struct Product: Codable, Identifiable {
    let category: ProductCategory
//    let image: String
    let title: String
    let currentPrice: Float
    let previousPrice: Float?
    let description: String
    let ingredients: String
    let weight: Weighth
    let colors: [Paint]
    var label: String?
    var id: String
}

extension Product: Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
