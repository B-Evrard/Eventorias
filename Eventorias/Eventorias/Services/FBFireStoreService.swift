//
//  FBFireStore.swift
//  Eventorias
//
//  Created by Bruno Evrard on 02/04/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class FBFireStore {
    
    let db = Firestore.firestore()
    
    
    // MARK: Event
    func fetchEvents(sortBy: SortOption, filterBy: String = "") async throws -> [Event] {
        var events: [Event] = []
        
        let FBEvents = db.collection("Events")
        
        let query: Query
        if filterBy.isEmpty {
            switch sortBy {
            case .date: query = FBEvents.order(by: "dateEvent", descending: false)
                break
            case .category: query = FBEvents.order(by: "category", descending: false)
                break
            }
        } else {
            switch sortBy {
            case .date: query = FBEvents
                    .whereField("titleSearch", isGreaterThanOrEqualTo: filterBy.removingAccentsUppercased)
                    .whereField("titleSearch", isLessThanOrEqualTo: "\(filterBy.removingAccentsUppercased)~")
                    .order(by: "dateEvent", descending: false)
                break
            case .category: query = FBEvents
                    .whereField("titleSearch", isGreaterThanOrEqualTo: filterBy.removingAccentsUppercased)
                    .whereField("titleSearch", isLessThanOrEqualTo: "\(filterBy.removingAccentsUppercased)Z")
                    .order(by: "category", descending: false)
                
                break
            }
            
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
    
    // MARK: User
    func addUser(_ user: EventoriasUser) async throws {
        try db.collection("Users").addDocument(from: user)
    }
    
    func getUser(id: String) async throws -> EventoriasUser?{
        var user: EventoriasUser?
        let FBUsers = db.collection("Users")
        let snapshot = try await FBUsers.whereField("id", isEqualTo: id).getDocuments()
        if (!snapshot.isEmpty) {
            user = try snapshot.documents[0].data(as : EventoriasUser.self)
        }
        return user
    }
    
    // MARK: secret
    func getSecret() async throws -> APIKeyStorage {
        var apiKey = APIKeyStorage(googleMapApi: "")
        let snapshot = try await db.collection("secret").getDocuments()
        if !snapshot.documents.isEmpty {
            let document = snapshot.documents[0]
            apiKey = try document.data(as: APIKeyStorage.self)
        }
        return apiKey
    }
    
    // MARK: Storage image
    
    func uploadImage(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            throw ImageUploadError.imageConversionFailed
        }
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/event_images/\(fileName).jpeg")
        
        // Upload de l'image
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            ref.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    continuation.resume(throwing: ImageUploadError.uploadFailed(error))
                } else {
                    continuation.resume()
                }
            }
        }
        
        // Récupération de l'URL de téléchargement
        return try await withCheckedThrowingContinuation { continuation in
            ref.downloadURL { url, error in
                if let error = error {
                    continuation.resume(throwing: ImageUploadError.urlRetrievalFailed(error))
                } else if let urlString = url?.absoluteString {
                    continuation.resume(returning: urlString)
                } else {
                    continuation.resume(throwing: ImageUploadError.urlRetrievalFailed(nil))
                }
            }
        }
    }
    
}
