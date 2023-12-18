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

}
