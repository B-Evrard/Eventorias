//
//  EventListViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 01/04/2025.
//

import Foundation

@MainActor
final class EventListViewModel: ObservableObject {
        
    private let fireStoreService: FBFireStore
    
    @Published var search: String = ""
    @Published var events: [EventViewData] = []
    @Published var selectedSortOption: SortOption = .date
    @Published var isError: Bool = false
    @Published var isLoading = false
    
    
    init(fireStoreService: FBFireStore = FBFireStore()) {
        self.fireStoreService = fireStoreService
    }
    
    func reloadData() async {
        isLoading = true
        await fetchEvents()
        isLoading = false
    }
    
    func fetchEvents() async  {
        do {
            self.isError = false
            let events = try await fireStoreService.fetchEvents(sortBy: selectedSortOption)
            #if DEBUG
                //try? await Task.sleep(nanoseconds: 5_000_000_000)
            #endif
            self.events = events.map { EventTransformer.transformToViewData($0) }
            //self.isError = true
        } catch {
            self.isError = true
        }
    }
    
    func addEventMock() async {
        let adresse: AdresseEvent = .init(
            adresse: "123 Rue des Métiers",
            adresse2: "60880 Jaux, France",
            latitude: 49.404519000000001,
            longitude: 2.7849428999999999
        )
        
        let newEvent: Event = .init(
            title: "Event Mock \(generateRandomWord(length: 5))",
            dateEvent: generateRandomDate(),
            description: "Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks. Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks.",
            imageURL: "https://firebasestorage.googleapis.com/v0/b/eventorias-47db6.firebasestorage.app/o/pexels-bertellifotografia-15138850.jpg?alt=media&token=9434ca44-bd3d-468a-a5dc-22a05a4a884a",
            adresseEvent: adresse
            , category: "Art"
        )
        
        do {
            try await fireStoreService.addEvent(newEvent)
            await reloadData()
        }
        catch {
            print("Error")
        }
    }
    
    
    func generateRandomDate() -> Date {
        // Date du jour
        let currentDate = Date()
        
        // Date du 31 décembre
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: currentDate)
        components.month = 12
        components.day = 31
        let endOfYearDate = Calendar.current.date(from: components)!
        
        // Générer une date aléatoire entre les deux dates
        let interval = endOfYearDate.timeIntervalSince(currentDate)
        let randomInterval = TimeInterval.random(in: 0...interval)
        let randomDate = currentDate.addingTimeInterval(randomInterval)
        
        return randomDate
    }

    func generateRandomWord(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((1...length).map { _ in letters.randomElement()! })
    }
    
}
