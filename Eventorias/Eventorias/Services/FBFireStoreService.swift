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
    
//    func fetchEvents() -> Result<[Event], Error> {
//        var events: [Event] = []
//        db.collection("Events").getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                return .failure(error)
//            } else {
//                for document in querySnapshot!.documents {
//                    do {
//                        let event = try document.data(as: Event.self)
//                        events.append(event)
//                    } catch {
//                        
//                    }
//                    
//                }
//                return .success(events)
//            }
//        }
//    }
    
    func fetchEvents() async throws -> [Event] {
        var events: [Event] = []
        let snapshot = try await db.collection("Events").getDocuments()
        for document in snapshot.documents {
            print("\(document.documentID): \(document.data())")
            let event = try document.data(as: Event.self)
            events.append(event)
                
        }
        //return try snapshot.documents.compactMap({ try $0.data(as: Event.self) }
        return events
        
        
    }
}
