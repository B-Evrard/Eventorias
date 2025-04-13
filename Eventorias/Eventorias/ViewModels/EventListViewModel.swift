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
    @Published var showProgress = false
    
    init(fireStoreService: FBFireStore = FBFireStore()) {
        self.fireStoreService = fireStoreService
    }
    
    func reloadData() async {
        showProgress = false
        isLoading = true
        let delayTask = Task {
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                if isLoading {
                    showProgress = true
                }
            } catch {
                showProgress = true
            }
        }
        
        await fetchEvents()
        isLoading = false
        delayTask.cancel()
        
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
        let newEvent: Event = .init(
            title: "Event Mock \(generateRandomWord(length: 5))",
            dateEvent: generateRandomDate(),
            description: "\(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) \(generateRandomWord(length: Int.random(in: 3...10))) "
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
