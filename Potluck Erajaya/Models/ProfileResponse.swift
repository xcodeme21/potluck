//
//  ProfileResponse.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 23/12/23.
//

import Foundation

struct ProfileResponse: Codable {
    let data: UserProfile?
    let error_message: String?
    let status: Int
    
    struct UserProfile: Codable {
        let id: Int?
        let name: String?
        let email: String?
        let nik: Int?
        let phone: Int?
    }
}

enum ErrorMessage: Error {
    case incompleteData
    case invalidURL
    case decodingError
}
