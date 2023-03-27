//
//  FiltersScreen.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import SwiftUI

struct FiltersScreen: View {
    
    private var viewModel: SortingScreenViewModel
    
    init(viewModel: SortingScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView{
            List {
                Section {
                    ForEach(0..<viewModel.data.count) { index in
                        let item = viewModel.data[index]
                        SortCell(viewModel: item)
                            .onTapGesture {
                                viewModel.selectItem(index: index)
                            }
                    }
                }
                Section {
                    sortingButton
                }
            }
            .background(Color.white)
            .listStyle(.plain)
            .navigationBarTitle("Sort by", displayMode: .large)
        }
    }
    
    private var sortingButton: some View {
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
        .clipShape(Capsule())
        .listRowSeparator(.hidden)
    }
    
}

//struct FiltersScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FiltersScreen()
//    }
//}
