//
//  BookingHistoryView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 18/12/23.
//

import Foundation
import SwiftUI

struct BookingHistoryView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var isShowingModal = false
    @State private var selectedBooking: IdentifiableHistory? = nil
    @State private var histories: [HistoriesResponse.HistoryData] = []
    @State private var errorMessage: String?
    
    var body: some View {
        VStack{
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(histories, id: \.id) { history in
                        HistoryCardView(history: history, profileViewModel: profileViewModel)
                            .onTapGesture {
                                selectedBooking = IdentifiableHistory(id: history.id, history: history)
                                isShowingModal = true
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Booking History")
        .sheet(item: $selectedBooking) { booking in
            DetailModalView(history: booking.history)
        }
        .onAppear {
            if let userData = homeViewModel.getUserDataFromUserDefaults() {
                profileViewModel.getHistories(email: userData.email, authorizationHeader: "Basic cG90bHVjazokMmEkMTJOcDB0VVRXMzR2ejZaNTV0TUxUbWMuMzBWNkNLWUlLNlNCN25IOU1TWkZ5a0xzQ3YycWlpNg==") { result in
                    switch result {
                    case .success(let data):
                        if let historiesData = data.data {
                            histories = historiesData
                        }
                        errorMessage = nil

                    case .failure(let error):
                        errorMessage = "Get events failed with error: \(error)"
                    }
                }
            }
        }
        .alert(isPresented: $profileViewModel.showAlert) {
            Alert(title: Text("Fetching failed"), message: Text("Get events failed with error."), dismissButton: .default(Text("OK")))
        }
    }
}

struct DetailModalView: View {
    let history: HistoriesResponse.HistoryData
    
    var body: some View {
        VStack {
            if let imageURL = URL(string: history.event.image) {
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
            Text(history.event.name)
                .font(.headline)
                .foregroundColor(.primary)
                .textCase(.uppercase)
            Spacer()
        }
    }
}


struct HistoryCardView: View {
    var history: HistoriesResponse.HistoryData
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var isShowDetail = false
    @State private var selectedBooking: Int?
    
    var body: some View {
        HStack(spacing: 12) {
            // Image on the left
            AsyncImage(url: URL(string: history.event.image)) { image in
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
                
                Text(history.event.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 4)
                    .textCase(.uppercase)
                
                DetailInfoRow(imageName: "calendar", infoText: history.queue.date)
                DetailInfoRow(imageName: "clock", infoText: history.queue.start_time + " - " + history.queue.end_time)
                DetailInfoRow(imageName: "mappin", infoText: history.event.location)
            }
            
            Divider()
                    .frame(height: 50) // Sesuaikan dengan tinggi kartu Anda
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(String(history.queue.no_segment))
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
