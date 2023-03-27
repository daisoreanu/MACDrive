//
//  SortingScreenViewModel.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import Foundation

class SortingScreenViewModel {
    
    let data: [SortingCellViewModel]
    typealias UpdateSortAction = (SortingOption?) -> Void
    
    
    private var currentSelection: SortingCellViewModel?
    private var updateSortAction: UpdateSortAction
    
    
    init(updateSortAction: @escaping UpdateSortAction) {
        self.data = SortingOption.allCases.map{ SortingCellViewModel(sort: $0) }
        self.updateSortAction = updateSortAction
    }
    
    func selectItem(index: Int) {
        currentSelection?.isSelected = false
        currentSelection = data[index]
        currentSelection?.isSelected = true
    }
    
    func commitChanges() {
        updateSortAction(SortingOption.newArrivals)
    }
    
}
