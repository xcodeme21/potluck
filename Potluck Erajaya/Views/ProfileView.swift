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
    let userName = UserDefaults.standard.string(forKey: "userData_name") ?? ""
    @State private var isBookingHistoryPresented = false
    
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
                    Text("Logout")
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
    }
}


