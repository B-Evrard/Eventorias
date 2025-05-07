//
//  LocationSearchService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 13/04/2025.
//

import Foundation
import MapKit

class LocationSearchService: LocationSearchProtocol {

    func getPlace(from address: AddressResult) async throws -> CLLocationCoordinate2D {
        let request = MKLocalSearch.Request()
        let title = address.title
        let subTitle = address.subtitle
        
        request.naturalLanguageQuery = subTitle.contains(title)
            ? subTitle
            : title + ", " + subTitle
        
        let response = try await MKLocalSearch(request: request).start()
        
        guard let firstResult = response.mapItems.first?.placemark else {
            throw GeocodingError.noResults
        }
        
        return firstResult.coordinate
    }
    
}


