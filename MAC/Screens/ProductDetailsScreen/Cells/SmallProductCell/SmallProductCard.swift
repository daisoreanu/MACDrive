//
//  SmallProductCard.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct SmallProductCard: View {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(uiImage: UIImage(named: product.title)!)
                .resizable()
                .scaledToFill()
                .frame(width: 138, height: 168)
            VStack(spacing: 0) {
                Text(product.title)
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                HStack {
                    if let previousPrice = product.previousPrice {
                        Text(String(format: "$%.2f", previousPrice))
                            .strikethrough()
                            .font(Font.system(size: 15, weight: .regular))
                            .foregroundColor(Color.white)
                        Text(String(format: "$%.2f", product.currentPrice))
                            .font(Font.system(size: 15, weight: .regular))
                            .foregroundColor(Color.red)
                        Spacer()
                    } else {
                        Text(String(format: "$%.2f", product.currentPrice))
                            .font(Font.system(size: 15, weight: .regular))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 4)
            .background(Color.black)
            
        }
        .frame(width: 138, height: 204)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
        .padding(.vertical)
    }
}

struct SmallProductCard_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(category: ProductCategory.lips(subcategory: .lipsticks),
                              title: "LIPSTICK | WAKANDA FOREVER",
                              currentPrice: 13.00,
                              previousPrice: 23.00,
                              description: "Paint a powerful pout with four all-new rich shades of lipstick in a variety of textures and colours to accentuate the curve of your smile. With hues inspired by the world of Wakanda, this limited-edition lineup includes our Amplified and Matte formulas. Each is shielded in special-edition Black Panther-inspired packaging.",
                              ingredients: "Ingredients: Octyldodecanol, Ricinus Communis (Castor) Seed Oil, Silica, Tricaprylyl Citrate, Ozokerite, Isononyl Isononanoate, Paraffin, Phenyl Trimethicone, Microcrystalline Wax | Cera Microcristallina | Cire Microcristalline, Ethylhexyl Palmitate, Caprylic/Capric Triglyceride, Copernicia Cerifera (Carnauba) Wax | Copernicia Cerifera Cera | Cire De Carnauba, Ascorbyl Palmitate, Tocopherol, Stearyl Stearoyl Stearate, Vanillin, Bht, [+/- Mica, Titanium Dioxide (Ci 77891), Iron Oxides (Ci 77491), Iron Oxides (Ci 77492), Iron Oxides (Ci 77499), Blue 1 Lake (Ci 42090), Carmine (Ci 75470), Red 6 (Ci 15850), Red 6 Lake (Ci 15850), Red 7 Lake (Ci 15850), Red 21 Lake (Ci 45380), Red 28 Lake (Ci 45410), Red 30 Lake (Ci 73360), Red 33 Lake (Ci 17200), Yellow 5 Lake (Ci 19140), Yellow 6 Lake (Ci 15985)]  ILN46425 ",
                              weight: Weighth.imperial(oz: 0.1),
                              colors: [
                                Paint(name: "Royal Integrity", hex: "552A1F"),
                                Paint(name: "Wakandan Sunset", hex: "722D7B"),
                                Paint(name: "Story of Home", hex: "a4645c"),
                                Paint(name: "Dora Milaje", hex: "731514")
                              ],
                              label: "BEST SELLER",
                              id: "1")
        SmallProductCard(product: product)
        
    }
}
