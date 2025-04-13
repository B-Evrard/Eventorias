//
//  EventViewData.swift
//  Eventorias
//
//  Created by Bruno Evrard on 04/04/2025.
//

import Foundation

struct EventViewData: Hashable, Decodable {
    let id: String
    let title: String
    let dateEvent: Date
    var description: String
    
    var dateFormatter: String {
        return dateEvent.formattedDate
    }
    
    var timeFormatter: String {
        return dateEvent.formattedTime
    }
    
    var accessibilityLabel: String {
        return "Events: \(title) on \(dateFormatter) at \(timeFormatter)"
    }
    
    
}
