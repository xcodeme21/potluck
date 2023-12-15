//
//  ContentView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 12/12/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, kamu berhasil login!")
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
