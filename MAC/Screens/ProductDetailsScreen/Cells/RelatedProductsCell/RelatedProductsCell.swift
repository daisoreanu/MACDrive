//
//  RelatedProductsCell.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import SwiftUI

struct RelatedProductsCell: View {
    
    private let products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("You may also like:")
                .font(Font.system(size: 28, weight: .bold))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(products) { product in
                        SmallProductCard(product: product)
                    }
                }
            }
            Spacer()
                .frame(height: 80)
        }
    }
}

//struct RelatedProductsCell_Previews: PreviewProvider {
//    static var previews: some View {
//        RelatedProductsCell()
//    }
//}
