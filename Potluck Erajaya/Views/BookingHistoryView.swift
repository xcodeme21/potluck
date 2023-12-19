//
//  BookingHistoryView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 18/12/23.
//

import Foundation
import SwiftUI

struct BookingHistoryView: View {
    @State private var isShowingModal = false
    @State private var selectedBooking: Int? = nil
    
    var body: some View {
        VStack{
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<5) { index in
                        HistoryCardView()
                            .onTapGesture {
                                selectedBooking = index
                                isShowingModal = true
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Booking History")
        .sheet(isPresented: $isShowingModal) {
            if let index = selectedBooking {
                DetailModalView(selectedBooking: index)
            }
        }
    }
}

struct DetailModalView: View {
    let selectedBooking: Int
    
    var body: some View {
        VStack {
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
            Text("Booking \(selectedBooking + 1)")
                       .font(.title)
                       .padding()
        }
    }
}


struct HistoryCardView: View {
    
    var body: some View {
        HStack(spacing: 12) {
            // Image on the left
            AsyncImage(url: URL(string: "https://foto.kontan.co.id/FPN05GIgN3RC-9HZEY2Ny-OLEYU=/smart/2021/02/11/1574363234p.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 130)
                    .clipShape(RoundedCorner(corner: [.topLeft, .bottomLeft], radius: 10))
                    .padding(.top, -40)
                    .padding(.bottom, -50)
            } placeholder: {
                // Placeholder view saat gambar sedang dimuat
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Potluck Ibox")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 4)
                    .textCase(.uppercase)
                
                DetailInfoRow(imageName: "calendar", infoText: "14 Dec 2023")
                DetailInfoRow(imageName: "clock", infoText: "10:00 - 11:00")
                DetailInfoRow(imageName: "mappin", infoText: "Erajaya Plaza")
            }
            
            Divider()
                    .frame(height: 50) // Sesuaikan dengan tinggi kartu Anda
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("10")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .fixedSize()
                }
                .padding(.trailing, 20)
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.bottom, 10)
    }
}

struct DetailInfoRow: View {
    let imageName: String
    let infoText: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray)
                .font(.caption2)
            
            Text(infoText)
                .font(.caption2)
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}



struct BookingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        return BookingHistoryView()
    }
}
