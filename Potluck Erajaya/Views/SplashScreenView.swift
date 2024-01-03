//
//  SplashScreenView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 15/12/23.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                AsyncImage(url: URL(string: "http://localhost:8000/images/logo/logo.png")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: min(geometry.size.width, geometry.size.height) * 0.5)
                    case .failure:
                        Text("Failed to load image")
                    case .empty:
                        ProgressView()
                    @unknown default:
                        Text("Unknown state")
                    }
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                Text("Powered by Eraspace.com")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
            }
        }
    }
}
