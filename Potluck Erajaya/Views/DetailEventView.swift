//
//  DetailEventView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 19/12/23.
//

import Foundation
import SwiftUI

struct DetailEventView: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if let imageURL = URL(string: "https://foto.kontan.co.id/FPN05GIgN3RC-9HZEY2Ny-OLEYU=/smart/2021/02/11/1574363234p.jpg") {
                        AsyncImage(url: imageURL) { phase in
                            GeometryReader { geometry in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.width)
                                        .clipped()
                                } else if phase.error != nil {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.width)
                                } else {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                VStack {
                    Text("Event Potluck")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.leading,5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InfoRow(imageName: "calendar", infoText: "14 Dec 2023 - 15 Dec 2023")
                    InfoRow(imageName: "clock", infoText: "10:00 - 18:00")
                    InfoRow(imageName: "mappin", infoText: "Erajaya Plaza")
                    
                    ScrollView {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quam mauris, consequat quis tortor ac, ornare pretium purus. Integer imperdiet quam id lectus porta porta. Nulla bibendum velit turpis, a ornare elit molestie eu. Nunc a faucibus est. Etiam bibendum pharetra erat eu blandit. Mauris tincidunt malesuada ex eget porttitor.")
                            .font(.caption)
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }

                }
                .padding(.top, -60)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Book")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 10)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 15)
                
                
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct InfoRow: View {
    let imageName: String
    let infoText: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray)
                .font(.caption2)
                .padding(.leading, 5)
            
            Text(infoText)
                .font(.caption2)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 1)
    }
}


struct DetailEventView_Previews: PreviewProvider {
    static var previews: some View {
        return DetailEventView()
    }
}
