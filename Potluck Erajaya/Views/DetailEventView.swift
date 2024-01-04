//
//  DetailEventView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 19/12/23.
//

import Foundation
import SwiftUI

struct DetailEventView: View {
    var eventId: Int
    @State private var detailEvent: DetailEventResponse.EventData?
    @ObservedObject var homeViewModel = HomeViewModel()
    @State private var errorMessage: String?
    @State private var isShowingModal = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = detailEvent?.image {
                    ZStack {
                        if let imageURL = URL(string: image) {
                            AsyncImage(url: imageURL) { phase in
                                GeometryReader { geometry in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.width)
                                            .clipped()
                                            .overlay(Color.black.opacity(0.3))
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
                }
                
                if let eventName = detailEvent?.name {
                        Text(eventName)
                            .font(.headline)
                            .textCase(.uppercase)
                            .padding(.horizontal)
                            .padding(.leading, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                
                if let startDate = detailEvent?.start_date, let endDate = detailEvent?.end_date {
                    InfoRow(imageName: "calendar", infoText: "\(startDate) - \(endDate)")
                }

                
                if let startTime = detailEvent?.start_time, let endTime = detailEvent?.end_time {
                    InfoRow(imageName: "clock", infoText: "\(startTime) - \(endTime)")
                }
                
                if let location = detailEvent?.location {
                    InfoRow(imageName: "mappin", infoText: location)
                }
                
                
                if let description = detailEvent?.description {
                    ScrollView {
                        Text(description)
                            .font(.caption)
                            .padding(.horizontal)
                            .padding(.leading,5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical,10)
                }
                
                if detailEvent?.badge_available == true && detailEvent?.badge_end_date != true && detailEvent?.badge_coming_soon == true && detailEvent?.badge_start_book == false {
                    
                    GeometryReader { geometry in
                        if let bookingDate = detailEvent?.booking_start_date, let bookingTime = detailEvent?.booking_start_time {
                            InformationCard(title: "Information", description: "Sorry, you can book this event on \(bookingDate), time \(bookingTime). Please choose another time😢", imageName: "info.circle")
                                .padding(.horizontal)
                        }
                    }.padding(.bottom, 10)
                }
                
                Spacer()
                
                if detailEvent?.badge_booked == true {
                    Button(action: {
                        isShowingModal = true
                    }) {
                        Text("Booked")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 10)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding(.bottom, 10)
                    }
                    .padding(.horizontal, 15)
                    
                } else {
                    if detailEvent?.badge_available == true && detailEvent?.badge_end_date != true && detailEvent?.badge_exclude_customer != true && detailEvent?.badge_start_book == true {
                        Button(action: {
                            isShowingModal = true
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
                    } else {
                        Button(action: {
                            isShowingModal = true
                        }) {
                            Text("Book")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 10)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(8)
                                .padding(.bottom, 10)
                        }
                        .padding(.horizontal, 15)
                    }
                }
            }
        }
        .onAppear {
            if let userData = homeViewModel.getUserDataFromUserDefaults() {
                homeViewModel.getDetailEvent(email: userData.email, authorizationHeader: "Basic cG90bHVjazokMmEkMTJOcDB0VVRXMzR2ejZaNTV0TUxUbWMuMzBWNkNLWUlLNlNCN25IOU1TWkZ5a0xzQ3YycWlpNg==", id: eventId) { result in
                    switch result {
                    case .success(let data):
                        if let eventData = data.data {
                            detailEvent=eventData
                        }
                        print(detailEvent)

                        errorMessage = nil

                    case .failure(let error):
                        errorMessage = "Get events failed with error: \(error)"
                    }
                }
            }
        }
        .alert(isPresented: $homeViewModel.showAlert) {
            Alert(title: Text("Fetching failed"), message: Text("Get detail events failed with error."), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $isShowingModal) {
            ModalBookForm(detailEvent: detailEvent)
        }
    }
}

struct ModalBookForm: View {
    var detailEvent: DetailEventResponse.EventData?
    @State private var selection: String?

    let names = [
        "Cyril",
        "Lana",
        "Mallory",
        "Sterling"
    ]
    
    var body: some View {
        NavigationView() {
            VStack {
                List(names, id: \.self, selection: $selection) { name in
                    Text(name)
                }
                .navigationTitle("Choose Available Time Segment")
                .navigationBarTitleDisplayMode(.inline)

                Spacer()
                
                Button(action: {
                }) {
                    Text("Booking")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 10)
                        .padding()
                        .background(selection != nil ? Color.accentColor : Color.gray)
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 15)
            }
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
        let eventId: Int = 0
        return DetailEventView(eventId: eventId)
    }
}

struct InformationCard: View {
    var title: String
    var description: String
    var imageName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: imageName)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
            }
            
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
