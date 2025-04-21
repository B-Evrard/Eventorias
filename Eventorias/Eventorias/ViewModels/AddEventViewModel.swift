//
//  AddEventViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 16/04/2025.
//

import Foundation
import MapKit


final class AddEventViewModel: NSObject, ObservableObject {
    
    @Published var event = EventViewData(
        id: "",
        title: "",
        dateEvent: Date(),
        description: "",
        imageUrl: "",
        address: "",
        latitude: 0,
        longitude: 0,
        category: .unknown
    )
    
    @Published var eventTime: String = "12:00"
    @Published var dateText: String = ""
    @Published var searchAddressText = ""
    @Published var isAdressSelected = false
    @Published var results: Array<AddressResult> = []
    @Published var capturedImage: UIImage?
    
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
//    func updateTimeEvent(_ hour: String) {
//        let calendrier = Calendar.current
//        guard let dateModifiee = calendrier.date(
//            bySettingHour: 17,
//            minute: 0,
//            second: 0,
//            of: event.dateEvent
//        ) else {
//            fatalError("Heure invalide")
//        }
//    }
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    func validate() {
        
    }
    
}

extension AddEventViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            results = completer.results.map {
                AddressResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

