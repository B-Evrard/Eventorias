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
    
    init(fireStoreService: FBFireStore = FBFireStore()) {
        self.fireStoreService = fireStoreService
        
    }
    
    func fetchEvents() async  {
        do {
            self.isError = false
            let events = try await fireStoreService.fetchEvents(sortBy: selectedSortOption)
            #if DEBUG
                sleep(2)
            #endif
            self.events = events.map { EventTransformer.transformToViewData($0) }
        } catch {
            self.isError = true
        }
    }
    
    func addEventMock() async {
        let newEvent: Event = .init(
            title: "Event Mock \(generateRandomWord(length: 5))",
            dateEvent: generateRandomDate()
        )
        
        do {
            try await fireStoreService.addEvent(newEvent)
            await fetchEvents()
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
