//
//  LoginResponse.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 15/12/23.
//

import Foundation

struct LoginResponse: Codable {
    let ldapSetting: Bool?
    let message: String
    let success: Bool
    let output: Output?
    
    struct Output: Codable {
        let email: String
        let group: String?
        let mailServer: [String]
        let name: String
        let title: String
        let username: String
        let yourIP: String
        
        enum CodingKeys: String, CodingKey {
            case email, group, name, title, username
            case mailServer = "mailserver"
            case yourIP = "your_ip"
        }
    }
}

struct UserData: Codable {
    let email: String
    let group: String?
    let mailServer: [String]
    let name: String
    let title: String
    let username: String
    let yourIP: String
    
    enum CodingKeys: String, CodingKey {
        case email, group, name, title, username
        case mailServer = "mailserver"
        case yourIP = "your_ip"
    }
}
