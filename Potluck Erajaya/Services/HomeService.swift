//
//  HomeService.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 21/12/23.
//

import Foundation

class HomeService {
    func updateUser(email: String, authorizationHeader: String, nik: Int, phone: Int, completion: @escaping (Result<UpdateUserResponse, Error>) -> Void) {
        let urlString = "http://localhost:8000/api/potluck/profile/update?email=\(email)"
        let url = URL(string: urlString)!
        let parameters = ["nik": nik, "phone": phone]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error creating JSON data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(UpdateUserResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func checkCompletionService(email: String, authorizationHeader: String, completion: @escaping (Result<CheckCompletionResponse, Error>) -> Void) {
        let urlString = "http://localhost:8000/api/potluck/profile/check-completion?email=\(email)"
        let url = URL(string: urlString)!

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
                    let response = try JSONDecoder().decode(CheckCompletionResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func updateUserService(email: String, phone: String, nik: String, authorizationHeader: String, completion: @escaping (Result<UpdateUserResponse, Error>) -> Void) {
        let urlString = "http://localhost:8000/api/potluck/profile/update?email=\(email)"
        let url = URL(string: urlString)!

        let parameters: [String: Any] = [
            "phone": phone,
            "nik": nik
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error creating JSON data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                do {
                    let response = try JSONDecoder().decode(UpdateUserResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print("Error decoding response: \(error)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getEventsService(email: String, authorizationHeader: String, completion: @escaping (Result<ListEventsResponse, Error>) -> Void) {
        let urlString = "http://localhost:8000/api/potluck/events?email=\(email)"
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
                    let decodedResponse = try JSONDecoder().decode(ListEventsResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getDetailEventService(email: String, authorizationHeader: String, id: Int, completion: @escaping (Result<DetailEventResponse, Error>) -> Void) {
        var urlComponents = URLComponents(string: "http://localhost:8000/api/potluck/events/\(id)")
        urlComponents?.queryItems = [URLQueryItem(name: "email", value: email)]

        guard let url = urlComponents?.url else {
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
                    let decodedResponse = try JSONDecoder().decode(DetailEventResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func bookEventService(email: String, queueId: Int, eventId: Int, authorizationHeader: String, completion: @escaping (Result<DetailEventResponse, Error>) -> Void) {
        let urlString = "http://localhost:8000/api/potluck/events?email=\(email)"
        let url = URL(string: urlString)!

        let parameters: [String: Any] = [
            "queue_id": queueId,
            "event_id": eventId
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error creating JSON data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                do {
                    let response = try JSONDecoder().decode(DetailEventResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print("Error decoding response: \(error)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
