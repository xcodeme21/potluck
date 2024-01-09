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
    @Published var nik: String = ""
    @Published var phone: String = ""
    @Published var showAlert: Bool = false
    @Published var showModal: Bool = false
    @Published var showSuccessAlert: Bool = false
    
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
    
    var isValidCredentials: Bool {
        return isValidPhone(phone) && isValidNik(nik)
    }
    func isValidPhone(_ phone: String) -> Bool {
        return phone.count <= 12 && phone.count > 6 && phone.hasPrefix("8")
    }

    func isValidNik(_ nik: String) -> Bool {
        return nik.count == 9
    }
    
    func updateProfile(email: String, authorizationHeader: String, completion: @escaping (Result<UpdateUserResponse, Error>) -> Void) {
        if let userData = getUserDataFromUserDefaults() {
            let phone = self.phone
            let nik = self.nik
            
            homeService.updateUserService(email: userData.email, phone: phone, nik: nik, authorizationHeader: authorizationHeader) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let response):
                    if response.data?.email == nil || response.data?.name == nil || response.data?.id == nil {
                        self.showAlert = true
                    } else {
                        self.showAlert = false
                        self.showModal = false
                        completion(.success(response))
                    }


                case .failure(let error):
                    print("Check completion failed with error: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getEvents(email: String, authorizationHeader: String, completion: @escaping (Result<ListEventsResponse, Error>) -> Void) {
        homeService.getEventsService(email: email, authorizationHeader: authorizationHeader) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if response.data == nil {
                    print("Response data is incomplete")
                    self.showAlert = true
                    completion(.failure(ErrorMessage.incompleteData))
                } else {
                    self.showAlert = false
                    completion(.success(response))
                }

            case .failure(let error):
                print("Fetching profile failed with error: \(error)")
                self.showAlert = false
                completion(.failure(error))
            }
        }
    }
    
    func getDetailEvent(email: String, authorizationHeader: String, id: Int , completion: @escaping (Result<DetailEventResponse, Error>) -> Void) {
        homeService.getDetailEventService(email: email, authorizationHeader: authorizationHeader, id: id) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if response.data == nil {
                    print("Response data is incomplete")
                    self.showAlert = true
                    completion(.failure(ErrorMessage.incompleteData))
                } else {
                    self.showAlert = false
                    completion(.success(response))
                }

            case .failure(let error):
                print("Fetching profile failed with error: \(error)")
                self.showAlert = false
                completion(.failure(error))
            }
        }
    }
    
    func bookEvent(email: String, queueId: Int, eventId: Int, authorizationHeader: String, completion: @escaping (Result<DetailEventResponse, Error>) -> Void) {
        if let userData = getUserDataFromUserDefaults() {
            
            homeService.bookEventService(email: userData.email, queueId: queueId, eventId: eventId, authorizationHeader: authorizationHeader) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let response):
                    print("hasil response", response)
                    if response.data == nil {
                        self.showAlert = true
                    } else {
                        self.showAlert = false
                        self.showSuccessAlert = true
                        completion(.success(response))
                    }


                case .failure(let error):
                   // print("Booking failed with error: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }


}
