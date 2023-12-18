//
//  ContentView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 12/12/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            TabView {
                EventView()
                    .tabItem {
                        Label("Event", systemImage: "calendar")
                    }
                    .tag(0)
                
                ProfileView(homeViewModel: homeViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(1)
            }

        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeViewModel = HomeViewModel() 
        return HomeView(homeViewModel: homeViewModel)
    }
}
