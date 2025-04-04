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
    
    init(fireStoreService: FBFireStore = FBFireStore()) {
        self.fireStoreService = fireStoreService
        
    }
    
    func fetchEvents() async  {
        do {
            let events = try await fireStoreService.fetchEvents()
            print (events)
        } catch {
            print(error.localizedDescription)
        }
        
        
        
    }
    
}
