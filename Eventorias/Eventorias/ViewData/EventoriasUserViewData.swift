//
//  EventoriasUserViewData.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/04/2025.
//

import Foundation

struct EventoriasUserViewData: Hashable, Decodable {
    
    let id: String
    let idAuth: String
    let name: String
    let email: String
    var imageURL: String?
    var notificationsEnabled: Bool
    
}
