//
//  ProfileService.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 23/12/23.
//

import Foundation

class ProfileService {
    func getProfileService(email: String, authorizationHeader: String, completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        let urlString = "https://potluck.eraspace.com/api/potluck/profile?email=\(email)"
        guard let url = URL(string: urlString) else {
            completion(.failure(ErrorMessage.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(ProfileResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}
