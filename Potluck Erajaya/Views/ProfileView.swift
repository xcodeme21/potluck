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
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.white
                        .clipShape(Circle())
                        .frame(width: 105, height: 105)
                        .shadow(radius: 5)
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                .padding(.bottom, -60)
                .zIndex(1)
                
                ZStack {
                    VStack {
                        if let userData = homeViewModel.getUserDataFromUserDefaults() {
                            Text(userData.name)
                                .font(.title)
                                .padding(.top, 70)
                            
                            Text(userData.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                                .padding(.bottom, 20)
                        } else {
                            Text("Name")
                                .font(.title)
                                .padding(.top, 70)
                            
                            Text("Email")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                                .padding(.bottom, 20)
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
                .padding(.top, -20)

                
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


