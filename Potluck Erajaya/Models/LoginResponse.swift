//
//  LoginResponse.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 15/12/23.
//

import Foundation

struct LoginResponse: Codable {
    let ldapSetting: Int
    let message: String
    let success: Int
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
