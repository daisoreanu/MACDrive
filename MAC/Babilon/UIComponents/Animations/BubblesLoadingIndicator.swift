//
//  BubblesLoadingIndicator.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import SwiftUI
import Combine

struct BubblesLoadingIndicator: View {
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 0.125, on: .main, in: .common).autoconnect()
    private let timing: Double = 0.125
    
    private let ballsCount = 6
    @State private var counter = 0
    
    private let frame: CGSize = CGSize(width: 150, height: 50)

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach(0..<ballsCount) { index in
                Circle()
                    .offset(y: counter == index ? -frame.height / 10 : frame.height / 10)
                    .fill(BabylonConstants.colors[index])
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onReceive(timer, perform: { _ in
            withAnimation(.easeInOut(duration: timing * 2)) {
                counter = counter == (ballsCount - 1) ? 0 : counter + 1
            }
        })
    }
}

struct BubblesLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        BubblesLoadingIndicator()
    }
}
