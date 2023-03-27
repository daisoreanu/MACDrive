//
//  TabBar.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import SwiftUI

struct TabBar: View {
    
    @State var start: Bool = true
    
    @ObservedObject private var babylon = Babylon.shared
    
    var body: some View {
        ZStack {
            NavigationStack {
                TabView {
                    productsTab
                    cartTab
                    profileTab
                }
                .accentColor(Color.black) //sets the color of the tab bar icons
                .onAppear{
                    babylon.setVoiceAssystentName("Babylon")
                    babylon.start()
                }
                .onDisappear{
                    babylon.stop()
                }
            }
            SpeechActivityIndicator(babylonState: babylon.state)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    private var productsTab: some View {
        ProductListScreen()
            .toolbarBackground(Color.white, for: .navigationBar, .tabBar) //sets the color of the tab bar background, it also converts it fom translucid to opaque
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
    }
    
    private var cartTab: some View {
        Text("Product details")
            .tabItem {
                Label("Cart", systemImage: "basket.fill")
            }
    }
    
    private var profileTab: some View {
        Text("Profile")
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
    }
    
}



struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
