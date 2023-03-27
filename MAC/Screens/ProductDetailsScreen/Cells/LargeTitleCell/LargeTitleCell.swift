//
//  LargeTitleCell.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import SwiftUI

struct LargeTitleCell: View {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(Font.system(size: 28, weight: .bold))
            .foregroundColor(Color.black)
            .lineLimit(2)
    }
}

//struct LargeTitleCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LargeTitleCell()
//    }
//}
