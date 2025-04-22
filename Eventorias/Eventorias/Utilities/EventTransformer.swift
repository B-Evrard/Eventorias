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
            address: event.addressEvent.address,
            latitude: event.addressEvent.latitude,
            longitude: event.addressEvent.longitude,
            category: EventCategory.from(event.category)
        )
    }
    
    static func transformToModel(_ eventViewData: EventViewData) -> Event {
        return Event(
            id: eventViewData.id,
            title: eventViewData.title,
            dateEvent: eventViewData.dateEvent,
            description: eventViewData.description,
            imageURL: eventViewData.imageUrl,
            addressEvent: AddressEvent(address: eventViewData.address, latitude: eventViewData.latitude, longitude: eventViewData.longitude),
            category: eventViewData.category.rawValue
        )
            
    }
}
