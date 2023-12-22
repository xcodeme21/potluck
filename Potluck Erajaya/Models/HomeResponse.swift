//
//  HomeResponse.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 21/12/23.
//

import Foundation

struct UpdateUserResponse: Codable {
    let data: UserData?
    let error_message: String?
    let status: Int
    
    struct UserData: Codable {
        let id: Int?
        let name: String?
        let email: String?
        let nik: Int?
        let phone: Int?
    }
}

struct CheckCompletionResponse: Codable {
    let data: StatusData?
    let error_message: String?
    let status: Int
    
    struct StatusData: Codable {
        let is_verified: Bool?
    }
}
