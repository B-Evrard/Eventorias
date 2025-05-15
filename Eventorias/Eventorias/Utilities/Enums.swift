//
//  Enums.swift
//  Eventorias
//
//  Created by Bruno Evrard on 07/04/2025.
//

import Foundation

enum SortOption: String, CaseIterable {
    case date
    case category
}

enum PictureType: String, CaseIterable {
    case event
    case user
    
    var folderName: String {
        switch self {
        case .event:
            return "event_images"
        case .user:
            return "user_images"
        }
    }
}

enum EventCategory: String, CaseIterable, Identifiable , Decodable{
    case exhibition
    case theater
    case concert
    case opera
    case dance
    case lecture
    case bookSigning
    case culturalFestival
    case musicFestival
    case conference
    case foodTruckEvent
    case localMarket
    case unknown

    var id: String { self.rawValue }

    var displayName: String {
        switch self {
        case .exhibition: return "Exhibition"
        case .theater: return "Theater"
        case .concert: return "Concert"
        case .opera: return "Opera"
        case .dance: return "Dance"
        case .lecture: return "Lecture"
        case .bookSigning: return "Book Signing"
        case .culturalFestival: return "Cultural Festival"
        case .musicFestival: return "Music Festival"
        case .conference: return "Conference"
        case .foodTruckEvent: return "Food Truck Event"
        case .localMarket: return "Local Market"
        case .unknown: return "Unknown"
        }
        
        
    }
}

extension EventCategory {
    static func from(_ rawValue: String) -> Self {
        Self(rawValue: rawValue) ?? .unknown
    }
}
