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
    
    func mapURL() -> String {
        let latitude = event.latitude
        let longitude = event.longitude
        let key = APIKeyService.shared.apiKeyStorage.googleMapApi
        let urlString = String.googleStaticMapURL(latitude: latitude, longitude: longitude, apiKey: key)
        return urlString
    }
    
}
