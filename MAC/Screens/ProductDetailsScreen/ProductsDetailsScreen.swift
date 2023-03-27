//
//  ProductsDetailsScreen.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

enum ProductDetailsCellData: Hashable {
    case largeImage(String)
    case largeTitle(String)
    case price(current: Float, previous: Float?)
    case quantity
    case description(String)
    case relatedItems(products: [Product])
}

struct ProductsDetailsScreen: View {
    
    private let product: Product
    private let relatedProducts: [Product]
    private let listData: [ProductDetailsCellData]
    
    init(product: Product, relatedProducts: [Product]) {
        self.product = product
        self.relatedProducts = relatedProducts
        self.listData =  [
            .largeImage(product.title),
            .largeTitle(product.title),
            .price(current: product.currentPrice, previous: product.previousPrice),
            .quantity,
            .description(product.description),
            .relatedItems(products: relatedProducts)
        ]
    }
    
    var body: some View {
        ZStack {
            List() {
                ForEach(listData, id: \.self) { product in
                    switch product {
                    case .largeImage(let imageName):
                        LargeImageCell(imageName: imageName)
                    case .largeTitle(let title):
                        LargeTitleCell(title: title)
                    case .price(current: let currentPrice, previous: let previousPrice):
                        PriceCell(currentPrice: currentPrice, previousPrice: previousPrice)
                    case .quantity:
                        QuantityCell()
                    case .description(let description):
                        DescriptionCell(description: description)
                    case .relatedItems(products: let products):
                        RelatedProductsCell(products: products)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            floatingButton
        }
    }
    
    private var floatingButton: some View {
        VStack {
            Spacer()
            Button {
                print("test")
            } label: {
                Image(systemName: "basket.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Add to cart")
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .clipShape(Capsule())
            .shadow(radius: 3)
            .foregroundColor(Color.white)
            .padding()
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
