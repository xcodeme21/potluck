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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, kamu berhasil login!")
            Button(action: {
                homeViewModel.logout()
            }) {
                Text("Logout")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()
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
