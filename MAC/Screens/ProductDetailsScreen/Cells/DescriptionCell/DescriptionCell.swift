//
//  DescriptionCell.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import SwiftUI

struct DescriptionCell: View {
    
    private let description: String
    @State private var isCollapsed = true
    
    init(description: String) {
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
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
        }
    }
}

//struct DescriptionCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DescriptionCell()
//    }
//}
