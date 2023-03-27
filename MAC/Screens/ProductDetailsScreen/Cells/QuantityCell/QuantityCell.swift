//
//  QuantityCell.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 23.03.2023.
//

import SwiftUI

struct QuantityCell: View {
    
    @State var counter = 0
    
    var body: some View {
        HStack() {
            Button {
                if counter > 0 {
                    counter -= 1
                }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(.plain)
            .background(Color.white)
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 3)
            )
            .clipShape(Circle())
            .frame(width: 40, height: 40)
            
            Text("\(counter)")
                .font(Font.system(size: 28, weight: .bold))
                .frame(width: 36)
            
            Button {
                counter += 1
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .buttonStyle(.plain)
            .background(Color.white)
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 3)
            )
            .clipShape(Circle())
            .frame(width: 40, height: 40)
        }
    }
}

struct QuantityCell_Previews: PreviewProvider {
    static var previews: some View {
        QuantityCell()
    }
}
