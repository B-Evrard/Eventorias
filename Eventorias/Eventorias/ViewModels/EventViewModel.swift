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
    
    var getMap : URL {
        let lien =  "https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key="
        
        return URL(string: lien)!
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
