//
//  MockFBFIreStoreService.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 05/05/2025.
//

import Foundation
@testable import Eventorias
import UIKit

class MockFBFIreStoreService: DataStore {
    
    var usersValid = MockUsers.mockUsers
    var shouldSucceed: Bool = true
    var uploadShouldSucceed: Bool = true
    var events = MockEventGenerator.generateEvents()
    
    func fetchEvents(sortBy: Eventorias.SortOption, filterBy: String) async throws -> [Eventorias.Event] {
        
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
        if shouldSucceed {
            let id = UUID().uuidString
            var newEvent = event
            newEvent.id = id
            events.append(newEvent)
        } else {
            throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
        }
    }
    
    func addUser(_ user: Eventorias.EventoriasUser) async throws -> String {
        
        let id = UUID().uuidString
        var newUser = user
        newUser.id = id
        usersValid.append(newUser)
        return id
 
    }
    
    func updateUser(_ user: Eventorias.EventoriasUser) async throws {
        if shouldSucceed {
            if let index = usersValid.firstIndex(where: { $0.id == user.id }) {
                usersValid[index] = user
            }
        } else {
            throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
        }
        
        
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
        if uploadShouldSucceed {
            return "https://eventorias.com/img/event/mock.jpg"
        } else {
            throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
        }
    }
    
    func deleteImage(url: String) async throws {
        if uploadShouldSucceed {
            guard let _ = URL(string: url) else {
                throw StorageError.invalidURL
            }
        } else {
            throw NSError(domain: "MockFBFIreStoreService", code: 1, userInfo: nil) as Error
        }
        
    }
    
}
