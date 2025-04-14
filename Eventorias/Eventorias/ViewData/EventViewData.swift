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
