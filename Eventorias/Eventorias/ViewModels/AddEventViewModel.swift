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
    
    private let fireStoreService: DataStore
    private let locationSearchService: PlaceResolving
    private let localSearchCompleter: MKLocalSearchCompleter
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
    @Published var isError = false
    @Published var errorMessage: String = ""
    
    @Published var isValidating = false
    
    init(
        userManager: UserManager,
        fireStoreService: DataStore = FBFireStoreService(),
        locationSearchService: PlaceResolving = LocationSearchService(),
        localSearchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()
    ) {
        self.userManager = userManager
        self.fireStoreService = fireStoreService
        self.locationSearchService = locationSearchService
        self.localSearchCompleter = localSearchCompleter
        super.init()
        self.localSearchCompleter.delegate = self
    }

    func searchAddress(_ searchableText: String) {
        guard searchableText.isEmpty == false else { return }
        localSearchCompleter.queryFragment = searchableText
    }
    
    func validate() async -> Bool {
        
        isError = false
        await MainActor.run { self.isValidating = true }
        defer { Task { @MainActor in self.isValidating = false } }
        do {
            try Control.addEvent(event: event, eventTime: eventTime, image: capturedImage, address: adresseResult)
        } catch let error {
            showError(message: error.message)
            return false
        }
        guard let capturedImage = capturedImage else {
            showError(message: AppMessages.genericError)
            return false
        }
        guard let adresseResult = adresseResult else {
            showError(message: AppMessages.genericError)
            return false
        }
        
        do {
            let imageUrl = try await fireStoreService.uploadImage(capturedImage, type: .event)
            event.imageUrl = imageUrl
            
            let location = try await locationSearchService.getPlace(from: adresseResult)
            event.latitude = location.latitude
            event.longitude = location.longitude
        } catch _ as GeocodingError {
            showError(message: AppMessages.adressNotFound)
            return false
        } catch {
            showError(message: AppMessages.genericError)
            return false
        }
        self.isValidating = true
        do {
            if let updatedDate = event.dateEvent.settingTime(hours: eventTime) {
                event.dateEvent = updatedDate
            }
            event.idUser = userManager.currentUser?.id ?? ""
            self.isValidating = true
            try await fireStoreService.addEvent(EventTransformer.transformToModel(event))
        }
        catch {
            showError(message: AppMessages.genericError)
            self.isValidating = false
            return false
        }
        self.isValidating = false
        return true
    }
    
   private func showError(message: String) {
        isError = true
        errorMessage = message
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

