//
//  LinesLoadingIndicator.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import SwiftUI
import Combine

struct LinesLoadingIndicator: View {
    
    @State private var isAnimating: Bool = false
    
    private let timing: Double = 0.25
    private let linesCount = 6
    private let frame: CGSize = CGSize(width: 150, height: 50)

    var body: some View {
        HStack(alignment: .center, spacing: frame.width / 10) {
            ForEach(0..<linesCount) { index in
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(BabylonConstants.colors[index])
                    .frame(maxHeight: isAnimating ? frame.height / 3 : .infinity)
                    .animation(
                        Animation
                            .easeInOut(duration: timing)
                            .repeatForever(autoreverses: true)
                            .delay(
                                index == 2 ? 0.0 :
                                (index == 1 || index == 3) ? timing / 3 :
                                timing / 3 * 2
                            )
                    )
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onAppear {
            isAnimating.toggle()
        }
    }
}


struct LinesLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LinesLoadingIndicator()
    }
}
