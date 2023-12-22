//
//  ContentView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 12/12/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var showModal = false
    
    var body: some View {
        VStack {
            TabView {
                EventView()
                    .tabItem {
                        Label("Event", systemImage: "calendar")
                    }
                    .tag(0)
                
                ProfileView(homeViewModel: homeViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(1)
            }
            .onAppear {
                if let userData = homeViewModel.getUserDataFromUserDefaults() {
                    homeViewModel.checkCompletion(email: userData.email, authorizationHeader: "Basic cG90bHVjazokMmEkMTJOcDB0VVRXMzR2ejZaNTV0TUxUbWMuMzBWNkNLWUlLNlNCN25IOU1TWkZ5a0xzQ3YycWlpNg==") { result in
                        switch result {
                        case .success(let isVerified):
                            if !isVerified {
                                print(isVerified, "fetch isVerified")
                                showModal = true // Show the modal when isVerified is false
                            }
                            homeViewModel.isVerified = isVerified // Update isVerified

                        case .failure(let error):
                            print("Check completion failed with error: \(error)")
                        }
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                ModalFormView(showModal: $showModal, homeViewModel: homeViewModel)
            }
            .onAppear {
                print(homeViewModel.isVerified, "is isVerified")
                print(showModal, "is showModal")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let homeViewModel = HomeViewModel() 
        return HomeView(homeViewModel: homeViewModel)
    }
}

struct ModalFormView: View {
    @Binding var showModal: Bool
    @State var whatsappNumber: Double?
    @State var nik: Double?
    @FocusState private var isFocused: Bool
    @State private var isWhastappValid: Bool = false
    @State private var isNikValid: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("Verify No. Whatsapp and NIK Erajaya").font(.headline).bold()
                Divider()
                    .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Please enter your NIK and WA number to continue booking the potluck.")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("This information will be used by Admin to contact you for potluck booking confirmation.")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: geometry.size.width * 0.84)
                .background(Color.blue)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .padding(.bottom, 30)
                
                Text("No. Whatsapp").font(.headline).bold()
                HStack {
                    Text("+62")
                        .padding(.trailing, 15)
                    TextField("WhatsApp Number", text: $homeViewModel.phone)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.blue)
                                .padding(.top, 35),
                            alignment: .top
                        )
                        .frame(width: geometry.size.width * 0.70)
                        .focused($isFocused)
                        .onAppear {
                            self.isFocused = true
                        }
                }
                
                Text("National Identification Card (NIK)").font(.headline).bold().padding(.top, 20)
                TextField("Enter NIK", text: $homeViewModel.nik)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.blue)
                            .padding(.top, 35),
                        alignment: .top
                    )
                    .frame(width: geometry.size.width * 0.83)
                    .keyboardType(.numberPad)
                
                Spacer()
                
                Button(action: {
                            }) {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 15)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .background(homeViewModel.isValidCredentials ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                            }
                            .padding(.top,10)
                            .disabled(!homeViewModel.isValidCredentials)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding()
        }
    }
    
}

