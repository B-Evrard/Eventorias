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
    let id: String
    let title: String
    let dateEvent: Date
    var description: String
    let imageUrl: String
    let adresse: String
    let latitude: Double
    let longitude: Double
    
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

enum Category: String,CaseIterable {
    
    case Music
    case Exhibition
    case Theater
    case Concert
    case Opera
    case Dance
    case Festival
    case Competition
    case Conference
    case Tasting
    
    var icon: String {
        switch self {
        case .football:
            return "sportscourt"
        case .natation:
            return "waveform.path.ecg"
        case .running:
            return "figure.run"
        case .marche:
            return "figure.walk"
        case .cyclisme:
            return "bicycle"
        case .unknown:
            return "questionmark"
        }
    }
    
    init (rawValue: String) {
        switch rawValue {
        case "football":
            self = .football
        case "natation":
            self = .natation
        case "running":
            self = .running
        case "marche":
            self = .marche
        case "cyclisme":
            self = .cyclisme
        default :
            self = .unknown
            
        }
    }
    
   
}

