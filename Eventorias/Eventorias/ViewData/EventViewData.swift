//
//  EventViewData.swift
//  Eventorias
//
//  Created by Bruno Evrard on 04/04/2025.
//

import Foundation

struct EventViewData: Decodable {
    let id: String
    let title: String
    let dateEvent: Date
    //let description: String
    
    var dateFormatter: String {
        return dateEvent.formattedDate
    }
}
