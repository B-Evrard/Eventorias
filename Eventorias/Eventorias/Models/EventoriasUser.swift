//
//  User.swift
//  Eventorias
//
//  Created by Bruno Evrard on 26/04/2025.
//

import Foundation
import FirebaseFirestore

struct EventoriasUser: Codable {
    @DocumentID var id: String?
    let idAuth: String
    let name: String
    let email: String
    let imageURL: String?
    let notificationsEnabled: Bool
}
    
