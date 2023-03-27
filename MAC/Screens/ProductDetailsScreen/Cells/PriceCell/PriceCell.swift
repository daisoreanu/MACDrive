//
//  PriceCell.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import SwiftUI

struct PriceCell: View {
    
    private let currentPrice: Float
    private let previousPrice: Float?
    
    init(currentPrice: Float, previousPrice: Float?) {
        self.currentPrice = currentPrice
        self.previousPrice = previousPrice
    }
    
    var body: some View {
        HStack {
            if let previousPrice = previousPrice {
                Text(String(format: "$%.2f", previousPrice))
                    .strikethrough()
                    .font(Font.system(size: 28, weight: .regular))
                    .foregroundColor(Color.black)
                Text(String(format: "$%.2f", currentPrice))
                    .font(Font.system(size: 28, weight: .regular))
                    .foregroundColor(Color.red)
                Spacer()
            } else {
                Text(String(format: "$%.2f", currentPrice))
                    .font(Font.system(size: 28, weight: .regular))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
    }
}

//struct PriceCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PriceCell()
//    }
//}
