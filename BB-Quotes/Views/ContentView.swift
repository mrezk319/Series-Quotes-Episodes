//
//  ContentView.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 06/07/2025.
//

import SwiftUI
struct ContentView: View {
    let vm = ViewModel() 
    var body: some View {
        TabView {
            Tab (Constants.bbName,systemImage: "tortoise") {
                
                VStack {
                    HomeView(show: Constants.bbName)
                }
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
             
            Tab (Constants.bcsName, systemImage: "briefcase") {
                HomeView(show: Constants.bcsName)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            } 
            
            Tab (Constants.elName, systemImage: "car") {
                HomeView(show: Constants.elName)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
