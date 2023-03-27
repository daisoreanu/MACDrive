//
//  LargeImageCell.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import SwiftUI

struct LargeImageCell: View {
    
    private let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(uiImage: UIImage(named: imageName)!)
            .resizable()
            .scaledToFill()
            .frame(height: 324)
            .padding(0)
    }
}

//struct LargeImageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        LargeImageCell()
//    }
//}
