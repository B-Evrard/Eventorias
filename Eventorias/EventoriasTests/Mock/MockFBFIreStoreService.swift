//
//  MockFBFIreStoreService.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 05/05/2025.
//

import Foundation
@testable import Eventorias
import UIKit

class MockFBFIreStoreService: FBFireStoreProtocol {
    
    func fetchEvents(sortBy: Eventorias.SortOption, filterBy: String) async throws -> [Eventorias.Event] {
        return MockEventGenerator.generateEvents()
    }
    
    func addEvent(_ event: Eventorias.Event) async throws {
        
    }
    
    func addUser(_ user: Eventorias.EventoriasUser) async throws -> String {
        return "123"
    }
    
    func updateUser(_ user: Eventorias.EventoriasUser) async throws {
        
    }
    
    func getUserByIdAuth(idAuth: String) async throws -> Eventorias.EventoriasUser? {
        if let foundUser = MockUsers.mockUsers.first(where: { $0.idAuth == idAuth }) {
            return foundUser
        } else {
            throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
        }
    }
    
    func getUserById(id: String) async throws -> Eventorias.EventoriasUser? {
        if let foundUser = MockUsers.mockUsers.first(where: { $0.id == id }) {
            return foundUser
        } else {
            throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
        }
    }
    
    func getSecret() async throws -> Eventorias.APIKeyStorage {
        return Eventorias.APIKeyStorage(googleMapApi: "mockKey")
    }
    
    func uploadImage(_ image: UIImage, type: Eventorias.PictureType) async throws -> String {
        return "https://eventorias.com/img/event/mock.jpg"
    }
    
    
}
