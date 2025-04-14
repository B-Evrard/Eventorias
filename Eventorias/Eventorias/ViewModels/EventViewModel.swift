//
//  EventDetailView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/04/2025.
//

import Foundation
import _MapKit_SwiftUI

final class EventViewModel: ObservableObject {
    @Published var event: EventViewData
    
    init(event: EventViewData) {
        self.event = event
    }
    
    func getEventMapCameraPosition() -> MapCameraPosition {
        
        return .camera(
            MapCamera(
                centerCoordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude),
                distance: 980,
                heading: 242,
                pitch: 60
            )
            
        )
    }
    
}
