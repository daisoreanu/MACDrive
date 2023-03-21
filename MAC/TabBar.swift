//
//  TabBar.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        NavigationStack {
            TabView {
                ProductsTab()
                    .navigationTitle("M·A·C")
                    .toolbarBackground(Color.white, for: .navigationBar, .tabBar)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    Text("Product details")
                        .navigationTitle("Details")
                        .toolbarBackground(Color.white, for: .navigationBar, .tabBar)
                .tabItem {
                    Label("Cart", systemImage: "basket.fill")
                }
                    Text("Profile")
                        .navigationTitle("M·A·C")
                        .toolbarBackground(Color.white, for: .navigationBar, .tabBar)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            }
            .accentColor(Color.black)
        }
        .onAppear{
            speechRecognizer.startListening()
        }
        .onDisappear{
            speechRecognizer.stopListening()
        }
        .accentColor(Color.black)
        
    }
}



struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
