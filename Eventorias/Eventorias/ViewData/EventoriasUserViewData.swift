//
//  EventoriasUserViewData.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/04/2025.
//

import Foundation

struct EventoriasUserViewData: Hashable, Decodable {
    
    let id: String
    let name: String
    let email: String
    let imageURL: String?
    var notificationsEnabled: Bool
    
}
