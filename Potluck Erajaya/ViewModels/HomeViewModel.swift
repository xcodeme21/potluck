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
    @Published var isVerified: Bool = false
    
    private var homeService: HomeService
    
    init(homeService: HomeService = HomeService()) {
        self.homeService = homeService
    }
        
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
    
    func checkCompletion(email: String, authorizationHeader: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        homeService.checkCompletionService(email: email, authorizationHeader: authorizationHeader) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let isVerified = response.data?.is_verified ?? false
                self.isVerified = isVerified
                completion(.success(isVerified))

            case .failure(let error):
                print("Check completion failed with error: \(error)")
                completion(.failure(error))
            }
        }
    }




}
