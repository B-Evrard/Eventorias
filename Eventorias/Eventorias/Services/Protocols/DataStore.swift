//
//  DataStore.swift
//  Eventorias
//
//  Created by Bruno Evrard on 05/05/2025.
//

import Foundation
import UIKit

protocol DataStore {
    // MARK: Event
    func fetchEvents(sortBy: SortOption, filterBy: String) async throws -> [Event]
    func addEvent(_ event: Event) async throws
    
    // MARK: Users
    func addUser(_ user: EventoriasUser) async throws -> String
    func updateUser(_ user: EventoriasUser) async throws
    func getUserByIdAuth(idAuth: String) async throws -> EventoriasUser?
    func getUserById(id: String) async throws -> EventoriasUser?
    
    // MARK: Secret
    func getSecret() async throws -> APIKeyStorage
    
    // MARK: Storage
    func uploadImage(_ image: UIImage, type: PictureType) async throws -> String
}
