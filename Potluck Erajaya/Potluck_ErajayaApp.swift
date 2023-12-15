//
//  Potluck_ErajayaApp.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 12/12/23.
//

import SwiftUI

@main
struct Potluck_ErajayaApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}

