//
//  SpeechActivityIndicator.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 27.03.2023.
//

import SwiftUI

struct SpeechActivityIndicator: View {
    
    private let babylonState: BabylonState
    
    init(babylonState: BabylonState) {
        self.babylonState = babylonState
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            switch babylonState {
            case .standby:
                EmptyView()
            case .recording(let string):
                speechBubble(title: "Listening", description: string, loadingStyle: .lines)
            case .final(let string):
                speechBubble(title: "Processing", description: string, loadingStyle: .bubbles)
            case .error( _):
                speechBubble(title: "Sorry", description: "I didn't get that", loadingStyle: .empty)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
    
    
    private var backgroundColor: some View {
        if case let .standby = babylonState {
            return AnyView(EmptyView())
        } else {
            return AnyView(Color.black.opacity(0.3))
        }
    }
    
    @ViewBuilder
    private func speechBubble(title: String, description: String, loadingStyle: LoadingStyle) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(Font.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                Spacer()
            }
            Text(description)
                .font(Font.body)
                .foregroundColor(Color.gray)
            HStack {
                Spacer()
                switch loadingStyle {
                case .bubbles:
                    BubblesLoadingIndicator()
                case .lines:
                    LinesLoadingIndicator()
                case .empty:
                    Spacer()
                        .frame(height: 50)
                }
                Spacer()
            }
        }
        .padding()
        .background{ Color.black }
        .opacity(0.85)
        .cornerRadius(20)
        .padding()
    }
    
    private enum LoadingStyle {
        case lines
        case bubbles
        case empty
    }
    
}
//
//struct SpeechActivityIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        SpeechActivityIndicator()
//    }
//}
