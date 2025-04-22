//
//  LocationSearchService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 13/04/2025.
//

import Foundation
import MapKit
import Combine

class LocationSearchService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var searchQuery = ""
    var completer: MKLocalSearchCompleter
    
    @Published var completions: [MKLocalSearchCompletion] = []
    var cancellable: AnyCancellable?
    
    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        cancellable = $searchQuery.assign(to: \.queryFragment, on: self.completer)
        completer.delegate = self
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.completions = completer.results
    }
    
    
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

//extension MKLocalSearchCompletion: Identifiable {}
