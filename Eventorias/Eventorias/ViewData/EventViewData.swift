//
//  EventViewData.swift
//  Eventorias
//
//  Created by Bruno Evrard on 04/04/2025.
//

import Foundation
import MapKit
import SwiftUI

struct EventViewData: Hashable, Decodable {
    var id: String
    var idUser: String
    var title: String
    var dateEvent: Date
    var description: String
    var imageUrl: String
    var address: String
    var latitude: Double
    var longitude: Double
    var category: EventCategory
    var urlPictureUser: String
    
    var dateFormatter: String {
        return dateEvent.formattedDate
    }
    
    var timeFormatter: String {
        return dateEvent.formattedTime
    }
    
    var accessibilityLabel: String {
        return "Events: \(title) on \(dateFormatter) at \(timeFormatter)"
    }
    
    var url: URL? {
        return URL(string: imageUrl)
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
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
struct AddressResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}
