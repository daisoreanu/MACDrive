//
//  ProductsTab.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct ProductsTab: View {
    
    private let rows = [GridItem(.adaptive(minimum: 20, maximum: 60))]
    @State var presentSheet = false
    @State private var data: [Product]
    private var originalData: [Product]
    
    init() {
        var localData: [Product] = []
        
        if let path = Bundle.main.path(forResource: "JsonData", ofType: ".json") {
            let url = URL(fileURLWithPath: path)
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: jsonData)
                localData = products
            } catch {
                print(error)
            }
        }
        self.data = localData
        self.originalData = localData
    }
    
    var body: some View {
        GeometryReader { innerGeometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.fixed(innerGeometry.size.width - 32))], spacing: 36) {
                    ForEach(data) { item in
                        NavigationLink(value: item) {
                            ProductCard(product: item)
                        }
                    }
                }
            }
        }
        .overlay(alignment: Alignment.bottomTrailing) {
            Button {
                presentSheet = true
            } label: {
                Image.init(systemName: "line.3.horizontal.decrease.circle.fill")
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
            .padding()
        }
        .sheet(isPresented: $presentSheet) {
            FiltersScreen(viewModel: FilterScreenViewModel(updateSortAction: { sort in
                presentSheet = false
                updateData(sort: sort)
            }))
            .presentationDetents([.height(475)])
            
        }
        .navigationDestination(for: Product.self) { product in
            let related = data.filter { $0.id != product.id }
            ProductsDetailsScreen(product: product, relatedProducts: related)
        }
    }
    
    func updateData(sort: Sort?) {
        data = originalData.sorted{ product1, product2 in
            if let label = product1.label {
                if label.lowercased() == Sort.bestSeller.text.lowercased() {
                    return true
                }
            }
            if let label = product2.label {
                if label.lowercased() == Sort.bestSeller.text.lowercased() {
                    return true
                }
            }
            return false
         }
    }
    
}

struct ProductsTab_Previews: PreviewProvider {
    static var previews: some View {
        ProductsTab()
    }
}
