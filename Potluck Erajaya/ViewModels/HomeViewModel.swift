//
//  HomeViewModel.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 15/12/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var shouldNavigateToHome = false
        
    func logout() {
        UserDefaults.standard.removeObject(forKey: "userData")
        isLoggedIn = false
        shouldNavigateToHome =  false
    }
    
    func getUserDataFromUserDefaults() -> UserData? {
        if let userData = UserDefaults.standard.data(forKey: "userData"),
           let decodedUserData = try? JSONDecoder().decode(UserData.self, from: userData) {
            return decodedUserData
        }
        return nil
    }

}
