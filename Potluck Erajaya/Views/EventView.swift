import SwiftUI

struct EventView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var events: [ListEventsResponse.EventData] = []
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(events, id: \.id) { event in
                            CardView(event: event, homeViewModel: homeViewModel)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Events")
            .onAppear {
                if let userData = homeViewModel.getUserDataFromUserDefaults() {
                    homeViewModel.getEvents(email: userData.email, authorizationHeader: "Basic cG90bHVjazokMmEkMTJOcDB0VVRXMzR2ejZaNTV0TUxUbWMuMzBWNkNLWUlLNlNCN25IOU1TWkZ5a0xzQ3YycWlpNg==") { result in
                        switch result {
                        case .success(let data):
                            if let eventData = data.data {
                                events = eventData
                            }
                            errorMessage = nil

                        case .failure(let error):
                            errorMessage = "Get events failed with error: \(error)"
                        }
                    }
                }
            }
            .alert(isPresented: $homeViewModel.showAlert) {
                Alert(title: Text("Fetching failed"), message: Text("Get events failed with error."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct CardView: View {
    @State private var isToDetailEvent = false
    var event: ListEventsResponse.EventData
    @ObservedObject var homeViewModel: HomeViewModel 
    
    var body: some View {
        NavigationLink(destination: DetailEventView(eventId: event.id), isActive: $isToDetailEvent) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: event.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 130)
                        .clipShape(RoundedCorner(corner: [.topLeft, .bottomLeft], radius: 10))
                        .padding(.top, -40)
                        .padding(.bottom, -40)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Spacer()
                        
                        if event.badge_end_date == true {
                            Text("Ended")
                                .font(.system(size: 10))
                                .frame(height: 15)
                                .foregroundColor(.white)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(Color.red)
                                .clipShape(RoundedCorner(corner: [.topLeft, .bottomRight], radius: 10))
                        } else {
                            if event.badge_coming_soon == true {
                                Text("Cooming Soon")
                                    .font(.system(size: 10))
                                    .frame(height: 15)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Color.orange)
                                    .clipShape(RoundedCorner(corner: [.topLeft, .bottomRight], radius: 10))
                            }
                            
                            if event.badge_available == true && event.badge_full_book == false {
                                Text("Available")
                                    .font(.system(size: 10))
                                    .frame(height: 15)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Color.blue)
                                    .clipShape(RoundedCorner(corner: [.topLeft, .bottomRight], radius: 10))
                            }
                            
                            if event.badge_full_book == true {
                                Text("Fullbook")
                                    .font(.system(size: 10))
                                    .frame(height: 15)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Color.red)
                                    .clipShape(RoundedCorner(corner: [.topLeft, .bottomRight], radius: 10))
                            }
                        }
                    }
                    
                    HStack {
                        VStack(spacing: 5) {
                            HStack {
                                Text(event.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .textCase(.uppercase)
                                Spacer()
                            }
                            
                            DetailInfoRow(imageName: "calendar", infoText: event.start_date + " - " + event.end_date)
                            DetailInfoRow(imageName: "clock", infoText: event.start_time + " - " + event.end_time)
                            DetailInfoRow(imageName: "doc.text.magnifyingglass", infoText: "Total quota " + String(event.total_quota))
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 36))
                    }
                    
                    
                }
                .padding(.trailing, 8)
            }
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.bottom, 10)
        }
    }
}
