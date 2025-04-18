//
//  FBFireStore.swift
//  Eventorias
//
//  Created by Bruno Evrard on 02/04/2025.
//

import Foundation
import FirebaseFirestore

class FBFireStore {
    
    let db = Firestore.firestore()
    
    func fetchEvents(sortBy: SortOption) async throws -> [Event] {
        var events: [Event] = []
        
        let FBEvents = db.collection("Events")
        let query: Query
        switch sortBy {
            case .date: query = FBEvents.order(by: "dateEvent", descending: true)
            break
            case .category: query = FBEvents.order(by: "title", descending: false)
            break
        }
        
        let snapshot = try await query.getDocuments()
        
        for document in snapshot.documents {
            let event = try document.data(as: Event.self)
            events.append(event)
        }
        return events
    }
    
    
    func addEvent(_ event: Event) async throws {
            try db.collection("Events").addDocument(from: event)
    }
}
