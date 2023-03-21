//
//  ProductCard.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct ProductCard: View {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Image(uiImage: UIImage(named: product.title)!)
                    .resizable()
                    .scaledToFit()
                    .background { Color.white }
                ZStack {
                    HStack {
                        Text(product.title)
                            .font(Font.system(size: 18, weight: .bold))
                            .foregroundColor(Color.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        VStack{
                            if let previousPrice = product.previousPrice {
                                Text(String(format: "$%.2f", previousPrice))
                                    .strikethrough()
                                    .font(Font.system(size: 18, weight: .regular))
                                    .foregroundColor(Color.white)
                                Text(String(format: "$%.2f", product.currentPrice))
                                    .font(Font.system(size: 18, weight: .regular))
                                    .foregroundColor(Color.red)
                            } else {
                                Spacer()
                                Text(String(format: "$%.2f", product.currentPrice))
                                    .font(Font.system(size: 18, weight: .regular))
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.black)
            }
            .overlay(alignment: .topTrailing) {
                if let label = product.label {
                    Text(label)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .roundedCorner(20, corners: [.bottomLeft, .topRight])
                }
            }
        }
        .cornerRadius(20)
        .shadow(color: Color.gray, radius: 3, x: 3, y: 3)
    }
}

struct ProductCard_Previews: PreviewProvider {
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
        ProductCard(product: product)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
