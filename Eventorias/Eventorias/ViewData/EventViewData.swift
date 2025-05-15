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
        return dateEvent.formattedString(withFormat: "MMMM d, yyyy")
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

struct AddressResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}
