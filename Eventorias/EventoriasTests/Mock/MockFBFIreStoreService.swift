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
    
    var usersValid = MockUsers.mockUsers
    var shouldSucceed: Bool = true
    
    func fetchEvents(sortBy: Eventorias.SortOption, filterBy: String) async throws -> [Eventorias.Event] {
        let events = MockEventGenerator.generateEvents()
        var filteredEvents = filterBy.isEmpty ? events : events.filter { $0.titleSearch?.hasPrefix(filterBy.uppercased()) == true }
        
        switch sortBy {
            case .date:
            filteredEvents.sort { $0.dateEvent < $1.dateEvent }
            break
        case .category:
            filteredEvents.sort {
                if $0.category.lowercased() == $1.category.lowercased() {
                    return $0.dateEvent < $1.dateEvent
                } else {
                    return $0.category < $1.category
                }
            }
            break
        @unknown default:
            break
        }
        return filteredEvents
    }
    
    func addEvent(_ event: Eventorias.Event) async throws {
        
    }
    
    func addUser(_ user: Eventorias.EventoriasUser) async throws -> String {
        
        let id = UUID().uuidString
        var newUser = user
        newUser.id = id
        usersValid.append(newUser)
        return id
 
    }
    
    func updateUser(_ user: Eventorias.EventoriasUser) async throws {
        
    }
    
    func getUserByIdAuth(idAuth: String) async throws -> Eventorias.EventoriasUser? {
        if shouldSucceed {
            if let foundUser = usersValid.first(where: { $0.idAuth == idAuth }) {
                return foundUser
            } else {
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func getUserById(id: String) async throws -> Eventorias.EventoriasUser? {
        if shouldSucceed {
            if let foundUser = usersValid.first(where: { $0.id == id }) {
                return foundUser
            } else {
                throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
            }
        } else {
            return nil
        }
    }
    
    func getSecret() async throws -> Eventorias.APIKeyStorage {
        return Eventorias.APIKeyStorage(googleMapApi: "mockKey")
    }
    
    func uploadImage(_ image: UIImage, type: Eventorias.PictureType) async throws -> String {
        return "https://eventorias.com/img/event/mock.jpg"
    }
    
    
}
