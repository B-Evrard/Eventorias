//
//  AddEventViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 16/04/2025.
//

import Foundation
import MapKit

@MainActor
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
    //@Published var searchAddressText = ""
    @Published var isAdressSelected = false
    @Published var results: Array<AddressResult> = []
    @Published var capturedImage: UIImage?
    @Published var showError = false
    @Published var errorMessage: String = ""
    
    private lazy var localSearchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        return completer
    }()
    
    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    func validate() async -> Bool {
        showError = false
        do {
            try Control.addEvent(event: event, image: capturedImage)
        } catch let error {
            showError = true
            errorMessage = error.message
            return false
        }
        return true
    }
    
}

extension AddEventViewModel: @preconcurrency MKLocalSearchCompleterDelegate {
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

