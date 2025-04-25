//
//  EventDetailView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/04/2025.
//

import Foundation

@MainActor
final class EventViewModel: ObservableObject {
    
    private let fireStoreService: FBFireStore
    @Published var event: EventViewData
    
    init(event: EventViewData, fireStoreService: FBFireStore = FBFireStore()) {
        self.event = event
        self.fireStoreService = fireStoreService
    }
    
    func mapURL() -> String {
        let latitude = event.latitude
        let longitude = event.longitude
        let key = APIKeyService.shared.apiKeyStorage.googleMapApi
        let urlString = "https://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&markers=color:red%7Csize:tiny%7C\(latitude),\(longitude)&zoom=12&size=149x72&maptype=roadmap&key=\(key)"
        return urlString
    }
    
}
