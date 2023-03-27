//
//  QuantityEventType.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation

enum QuantityEventType: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    var description: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_US")
        formatter.numberStyle = .spellOut
        let number = formatter.string(from: NSNumber(value: self.rawValue))!
        return number
    }
    
}
