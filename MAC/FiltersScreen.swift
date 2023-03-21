//
//  FiltersScreen.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import SwiftUI

enum Sort: CaseIterable {
    
    case newArrivals
    case bestSeller
    case highestPriceFirst
    case lowestPriceFirst
    
    var text: String {
        switch self {
        case .newArrivals:
            return "New Arrivals"
        case .bestSeller:
            return "Best Seller"
        case .highestPriceFirst:
            return "Highest Price First"
        case .lowestPriceFirst:
            return "Lowest Price First"
        }
    }
    
}

class FilterCellViewModel: ObservableObject, Hashable {
    
    static func == (lhs: FilterCellViewModel, rhs: FilterCellViewModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    let sort: Sort
    @Published var isSelected: Bool
    
    init(sort: Sort, isSelected: Bool = false) {
        self.sort = sort
        self.isSelected = isSelected
    }
    
    var title: String {
        return sort.text
    }
    
}


class FilterScreenViewModel {
    
    let data: [FilterCellViewModel]
    typealias UpdateSortAction = (Sort?) -> Void
    
    
    private var currentSelection: FilterCellViewModel?
    private var updateSortAction: UpdateSortAction
    
    
    init(updateSortAction: @escaping UpdateSortAction) {
        self.data = Sort.allCases.map{ FilterCellViewModel(sort: $0) }
        self.updateSortAction = updateSortAction
    }
    
    func selectItem(index: Int) {
        currentSelection?.isSelected = false
        currentSelection = data[index]
        currentSelection?.isSelected = true
    }
    
    func commitChanges() {
        updateSortAction(Sort.newArrivals)
    }
    
}

struct FiltersScreen: View {
    
    private var viewModel: FilterScreenViewModel
    
    init(viewModel: FilterScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView{
                List {
                    Section {
                        ForEach(0..<viewModel.data.count) { index in
                            let item = viewModel.data[index]
                            FilterCell(viewModel: item)
                                .onTapGesture {
                                    viewModel.selectItem(index: index)
                                }
                        }
                    }
                    
                    Section {
                        Button {
                            viewModel.commitChanges()
                        } label: {
                            Text("Save changes")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .font(Font.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.white)
                                .background(Color.black)
                                .padding(.vertical)
                        }
                        .frame(height: 50)
                        .listRowSeparator(.hidden)
                    }
                }
                .background(Color.white)
                .listStyle(.plain)
            .navigationBarTitle("Sort by", displayMode: .large)
        }
    }
    
    
    
}

//struct FiltersScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FiltersScreen()
//    }
//}
