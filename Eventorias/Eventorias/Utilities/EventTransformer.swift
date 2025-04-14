//
//  EventTransformer.swift
//  Eventorias
//
//  Created by Bruno Evrard on 05/04/2025.
//

import Foundation

struct EventTransformer {
    static func transformToViewData(_ event: Event) -> EventViewData {
        return EventViewData(
            id: event.id ?? "",
            title: event.title,
            dateEvent: event.dateEvent,
            description: event.description,
            imageUrl: event.imageURL,
            adresse: "\(event.adresseEvent.adresse) \(event.adresseEvent.adresse2)",
            latitude: event.adresseEvent.latitude,
            longitude: event.adresseEvent.longitude
        )
    }
}
