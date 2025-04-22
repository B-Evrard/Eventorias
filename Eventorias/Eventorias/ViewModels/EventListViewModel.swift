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
    
    
}
