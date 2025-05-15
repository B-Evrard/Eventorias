//
//  MockLocationSearchService.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 07/05/2025.
//

import Foundation
import MapKit
@testable import Eventorias

class MockLocationSearchService: PlaceResolving {
    
    var shouldSucceed: Bool = true
    
    func getPlace(from address: Eventorias.AddressResult) async throws -> CLLocationCoordinate2D {
        if (shouldSucceed) {
            let location = CLLocationCoordinate2D(latitude: 48.8606, longitude: 2.3376)
            return location
        } else {
            throw GeocodingError.noResults
        }
        
        
    }
    
}
