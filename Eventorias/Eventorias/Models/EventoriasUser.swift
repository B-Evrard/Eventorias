//
//  User.swift
//  Eventorias
//
//  Created by Bruno Evrard on 26/04/2025.
//

import Foundation

struct EventoriasUser: Codable {
    let id: String
    let name: String
    let email: String
    let imageURL: String?
    let notificationsEnabled: Bool
}
    
