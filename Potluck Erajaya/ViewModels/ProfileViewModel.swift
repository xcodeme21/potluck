//
//  ProfileViewModel.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 23/12/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    private var profileService: ProfileService
    @Published var showAlert: Bool = false

    init(profileService: ProfileService = ProfileService()) {
        self.profileService = profileService
    }

    func getProfile(email: String, authorizationHeader: String, completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        profileService.getProfileService(email: email, authorizationHeader: authorizationHeader) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if response.data?.email == nil || response.data?.name == nil || response.data?.id == nil {
                    print("Response data is incomplete")
                    completion(.failure(ErrorMessage.incompleteData))
                } else {
                    completion(.success(response))
                }

            case .failure(let error):
                print("Fetching profile failed with error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getHistories(email: String, authorizationHeader: String, completion: @escaping (Result<HistoriesResponse, Error>) -> Void) {
        profileService.getHistoriesService(email: email, authorizationHeader: authorizationHeader) { [weak self] result in
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
}
