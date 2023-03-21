//
//  FilterCell.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import SwiftUI

struct FilterCell: View {
    
    @ObservedObject private var viewModel: FilterCellViewModel
    
    init(viewModel: FilterCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.title)
                .font(Font.system(size: 18))
                .padding()
            Spacer()
            if viewModel.isSelected {
                Image(uiImage: UIImage.init(systemName: "checkmark.circle.fill")!)
            }
        }
    }
    
}

//struct FilterCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterCell(text: "Test", isSelected: true)
//    }
//}
