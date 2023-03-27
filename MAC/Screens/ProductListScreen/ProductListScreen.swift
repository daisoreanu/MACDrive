//
//  ProductsTab.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct ProductListScreen: View {
    
    private let rows = [GridItem(.adaptive(minimum: 20, maximum: 60))]
    @State private var presentSheet = false
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
        NavigationView{
            GeometryReader { innerGeometry in
                
                List(data) { item in
                    ZStack {
                        NavigationLink(value: item) { EmptyView() }.opacity(0.0)
                        ProductCard(product: item)
                            .padding()
                            .onAppear {
                                Babylon.shared.addEvent(EventType.select(SelectEventType.product(name: item.title, id: item)),
                                                        screenClass: "ProductListScreen",
                                                        screenDescription: "Products List")
                            }
                            .onDisappear {
                                Babylon.shared.removeEvent(EventType.select(SelectEventType.product(name: item.title, id: item)), screenClass: "ProductListScreen")
                            }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                //                ScrollView(.vertical, showsIndicators: false) {
                //                    LazyVGrid(columns: [GridItem(.fixed(innerGeometry.size.width - 32))], spacing: 36) {
                //                        ForEach(data) { item in
                //
                //                        }
                //                    }
                //                }
                .overlay(alignment: Alignment.bottomTrailing) {
                    sortingButton
                }
                .sheet(isPresented: $presentSheet) {
                    FiltersScreen(viewModel: SortingScreenViewModel(updateSortAction: { sort in
                        presentSheet = false
                        updateData(sortingOption: sort)
                    }))
                    .presentationDetents([.height(475)])
                }
                .navigationDestination(for: Product.self) { product in
                    let related = data.filter { $0.id != product.id }
                    ProductsDetailsScreen(product: product, relatedProducts: related)
                }
            }
            .navigationBarTitle("M·A·C", displayMode: .large)
        }
    }
    
    private func updateData(sortingOption: SortingOption?) {
        data = originalData.sorted{ product1, product2 in
            if let label = product1.label {
                if label.lowercased() == SortingOption.bestSeller.text.lowercased() {
                    return true
                }
            }
            if let label = product2.label {
                if label.lowercased() == SortingOption.bestSeller.text.lowercased() {
                    return true
                }
            }
            return false
        }
    }
    
    private var sortingButton: some View {
        Button {
            presentSheet = true
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            Text("Sort")
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule())
        .frame(width: 100, height: 40)
        .shadow(radius: 3)
        .padding()
        .foregroundColor(.black)
    }
    
}

struct ProductListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductListScreen()
    }
}
