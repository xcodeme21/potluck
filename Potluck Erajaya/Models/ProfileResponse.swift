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
    case invalidUserData
    case bookingFailed
    case noDataReceived
}

struct HistoriesResponse: Codable {
    let data: [HistoryData]?
    let error_message: String?
    let status: Int
    
    struct HistoryData: Codable {
        let id: Int
        let seq_number: Int
        let event_id: Int
        let queue_id: Int
        let user_id: Int
        let present: Bool
        let present_at: String?
        let created_at: String
        let updated_at: String
        let event: EventHistory
        let queue: QueueHistory
        let employee: EmployeeHistory
        
        struct EventHistory: Codable {
            let id: Int
            let name: String
            let start_date: String
            let end_date: String
            let start_time: String
            let end_time: String
            let booking_start_date: String
            let booking_start_time: String
            let total_quota: Int
            let location: String
            let description: String
            let image: String
            let exclude_customer: String?
        }
        
        struct QueueHistory: Codable {
            let id: Int
            let quota: Int
            let start_time: String
            let end_time: String
            let date: String
            let no_segment: Int
            let segment_met: Int
        }
        
        struct EmployeeHistory: Codable {
            let id: Int
            let name: String
            let email: String
            let nik: Int?
            let phone: Int?
        }
        
    }
}

struct IdentifiableHistory: Identifiable {
    let id: Int
    let history: HistoriesResponse.HistoryData
}
