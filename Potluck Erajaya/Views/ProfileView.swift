//
//  ProfileView.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 18/12/23.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var isBookingHistoryPresented = false
    @State private var userProfile: ProfileResponse?
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.white
                        .clipShape(Circle())
                        .frame(width: 82, height: 82)
                        .shadow(radius: 5)
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
                .padding(.top, 50)
                .zIndex(1)
                
                ZStack {
                    VStack {
                        if let userData = homeViewModel.getUserDataFromUserDefaults() {
                            Text(userData.name)
                                .font(.headline)
                                .padding(.top, 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                        .padding(.trailing, 5)
                                    
                                    Text(userData.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top,5)
                                
                                if let userProfile = userProfile {
                                    ProfileDataView(profile: userProfile)
                                }
                            }
                            .padding(.top,10)
                            .padding(.bottom,20)
                            .padding(.leading, -75)
                            
                            Divider()
                            
                            NavigationLink(destination: BookingHistoryView(), isActive: $isBookingHistoryPresented) {
                                HStack {
                                    Text("Booking History")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                }
                                .padding()
                            }

                        } else {
                            Text("Name")
                                .font(.title)
                                .padding(.top, 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                        .padding(.trailing, 5)
                                    
                                    Text("Email")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top,5)
                                
                                HStack {
                                    Image(systemName: "person.crop.rectangle.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                        .padding(.trailing, 5)
                                    
                                    Text("202005075")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top,5)
                                
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                        .padding(.trailing, 5)
                                    
                                    Text("6285703696988")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top,5)
                            }
                            .padding(.top,10)
                            .padding(.bottom,20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 0)
                .padding()
                .navigationTitle("Profile")
                .padding(.top, -70)

                
                Spacer()
                
                Button(action: {
                    homeViewModel.logout()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 10)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 1)
                        )
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
                .padding(.horizontal, 15)
            }
        }
        .onAppear {
            if let userData = homeViewModel.getUserDataFromUserDefaults() {
                profileViewModel.getProfile(email: userData.email, authorizationHeader: "Basic cG90bHVjazokMmEkMTJOcDB0VVRXMzR2ejZaNTV0TUxUbWMuMzBWNkNLWUlLNlNCN25IOU1TWkZ5a0xzQ3YycWlpNg==") { result in
                    switch result {
                    case .success(let data):
                        print(data)
                        self.userProfile = data
                        
                    case .failure(let error):
                        print("Fetching profile failed with error: \(error)")
                    }
                }
            }
        }
    }
}

struct ProfileDataView: View {
    let profile: ProfileResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "person.crop.rectangle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.trailing, 5)
                
                if let nik = profile.data?.nik {
                    let nikString = String(nik).replacingOccurrences(of: ".", with: "")
                    Text("\(nikString)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("NIK not available")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 5)
            
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.trailing, 5)
                
                if let phone = profile.data?.phone {
                    let phoneString = String(phone).replacingOccurrences(of: ".", with: "")
                    Text("\(phoneString)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("Phone number not available")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 5)
        }
        .padding(.bottom, 20)
    }
}
