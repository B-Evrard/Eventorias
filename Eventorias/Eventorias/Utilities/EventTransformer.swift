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
            description: event.description
        )
    }
}
