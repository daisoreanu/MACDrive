//
//  SortingScreenViewModel.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import Foundation

class SortingCellViewModel: ObservableObject {
    
    private let sort: SortingOption
    @Published var isSelected: Bool
    
    init(sort: SortingOption, isSelected: Bool = false) {
        self.sort = sort
        self.isSelected = isSelected
    }
    
    var title: String {
        return sort.text
    }
    
}

extension SortingCellViewModel: Hashable {
    static func == (lhs: SortingCellViewModel, rhs: SortingCellViewModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
