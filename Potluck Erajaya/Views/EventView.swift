//
//  EventView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 18/12/23.
//

import Foundation
import SwiftUI

struct EventView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Event List")
                    .font(.title)
                // Add your event list content here
            }
            .padding()
            .navigationTitle("Event")
        }
    }
}
