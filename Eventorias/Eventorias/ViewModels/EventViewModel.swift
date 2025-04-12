//
//  EventDetailView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/04/2025.
//

import Foundation

final class EventViewModel: ObservableObject {
    @Published var event: EventViewData
    
    init(event: EventViewData) {
        self.event = event
    }
}
