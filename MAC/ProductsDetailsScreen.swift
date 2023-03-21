//
//  ProductsDetailsScreen.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct ProductsDetailsScreen: View {
    
    @State var isCollapsed = true
    @State var counter = 0
    
    
    private let product: Product
    private let relatedProducts: [Product]
    
    init(product: Product, relatedProducts: [Product]) {
        self.product = product
        self.relatedProducts = relatedProducts
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Image.init(uiImage: UIImage(named: product.title)!)
                    .resizable()
                
                    .scaledToFill()
                    .frame(height: 324)
                    .padding(0)
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(Font.system(size: 28, weight: .bold))
                        .foregroundColor(Color.black)
                        .lineLimit(2)
                    HStack {
                        if let previousPrice = product.previousPrice {
                            Text(String(format: "$%.2f", previousPrice))
                                .strikethrough()
                                .font(Font.system(size: 28, weight: .regular))
                                .foregroundColor(Color.black)
                            Text(String(format: "$%.2f", product.currentPrice))
                                .font(Font.system(size: 28, weight: .regular))
                                .foregroundColor(Color.red)
                            Spacer()
                        } else {
                            Text(String(format: "$%.2f", product.currentPrice))
                                .font(Font.system(size: 28, weight: .regular))
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    HStack {
                        Button {
                            if counter > 0 {
                                counter -= 1
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .background(Color.white)
                        .overlay(
                            Circle()
                                .stroke(.white, lineWidth: 3)
                        )
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        Text("\(counter)")
                            .font(Font.system(size: 28, weight: .bold))
                        Button {
                            counter += 1
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .background(Color.white)
                        .overlay(
                            Circle()
                                .stroke(.white, lineWidth: 3)
                        )
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        
                    }
                    Text(product.description)
                        .frame(maxHeight: isCollapsed ? 100 : .infinity)
                    Button {
                        self.isCollapsed = !self.isCollapsed
                    } label: {
                        let title = self.isCollapsed ? "show more" : "show less"
                        Text(title)
                            .font(.callout)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 8)
                    }
                    
                    Text("You may also like:")
                        .font(Font.system(size: 28, weight: .bold))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(relatedProducts) { product in
                                SmallProductCard(product: product)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 50)
                }
                .padding(.horizontal)
            }
        }
        .overlay(alignment: Alignment.bottom) {
            Button {
                
            } label: {
                Text("Add to cart")
                    .font(Font.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.black)
            
        }        
    }
}

struct ProductsDetailsScreen_Previews: PreviewProvider {
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
        ProductsDetailsScreen(product: product, relatedProducts: [product, product])
    }
}
