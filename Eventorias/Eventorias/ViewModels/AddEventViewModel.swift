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
    
    private let fireStoreService: FBFireStore
    private let locationSearchService: LocationSearchService
    @Published var userManager: UserManager
    
    @Published var event = EventViewData(
        id: "",
        idUser: "",
        title: "",
        dateEvent: Date(),
        description: "",
        imageUrl: "",
        address: "",
        latitude: 0,
        longitude: 0,
        category: .unknown,
        urlPictureUser: ""
        
    )
    
    @Published var eventTime: String = "12:00"
    @Published var dateText: String = ""
    @Published var isAdressSelected = false
    @Published var results: Array<AddressResult> = []
    @Published var adresseResult: AddressResult?
    @Published var capturedImage: UIImage?
    @Published var showError = false
    @Published var errorMessage: String = ""
    
    @Published var isValidating = false
    
    init(userManager: UserManager, fireStoreService: FBFireStore = FBFireStore(), locationSearchService: LocationSearchService = LocationSearchService() ) {
        self.userManager = userManager
        self.fireStoreService = fireStoreService
        self.locationSearchService = locationSearchService
    }
    
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
        
        await MainActor.run { self.isValidating = true }
        defer { Task { @MainActor in self.isValidating = false } }
        
        showError = false
        do {
            try Control.addEvent(event: event, eventTime: eventTime, image: capturedImage, address: adresseResult)
        } catch let error {
            showError = true
            errorMessage = error.message
            return false
        }
        
        do {
            let imageUrl = try await fireStoreService.uploadImage(capturedImage!, type: .event) // !!!capturedImage est controlé dans Control.addEvent(event: event, image: capturedImage)!!!
            event.imageUrl = imageUrl
        }
        catch {
            showError = true
            errorMessage = "An error has occured"
        }
        
        do {
            let location = try await locationSearchService.getPlace(from: adresseResult!) // !!!adresseResult est controlé dans Control.addEvent(event: event, image: capturedImage)!!!
            event.latitude = location.latitude
            event.longitude = location.longitude
        } catch {
            showError = true
            errorMessage = "Address not found"
        }
        self.isValidating = true
        do {
            if let updatedDate = event.dateEvent.settingTime(hours: eventTime) {
                event.dateEvent = updatedDate
            }
            event.idUser = userManager.currentUser?.id ?? ""
            try await fireStoreService.addEvent(EventTransformer.transformToModel(event))
            
        }
        catch {
            showError = true
            errorMessage = "An error has occured"
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

