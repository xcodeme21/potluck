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

struct ListEventsResponse: Codable {
    let data: [EventData]?
    let error_message: String?
    let status: Int
    
    struct EventData: Codable {
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
        let status: Int
        let created_at: String
        let updated_at: String
        let badge_booked: Bool
        let badge_coming_soon: Bool
        let badge_exclude_customer: Bool
        let badge_full_book: Bool
        let badge_available: Bool
        let badge_end_date: Bool
    }
}

struct DetailEventResponse: Codable {
    let data: EventData?
    let error_message: String?
    let status: Int
    
    struct EventData: Codable {
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
        let status: Int
        let created_at: String
        let updated_at: String
        let badge_booked: Bool
        let badge_coming_soon: Bool
        let badge_exclude_customer: Bool
        let badge_full_book: Bool
        let badge_available: Bool
        let badge_end_date: Bool
        let badge_start_book: Bool
        let queues: [QueueData]?
    }
    
        struct QueueData: Codable {
            let id: Int
            let quota: String
            let start_time: String
            let end_time: String
            let date: String
            let no_segment: Int
            let segment_met: Int
        }
}


