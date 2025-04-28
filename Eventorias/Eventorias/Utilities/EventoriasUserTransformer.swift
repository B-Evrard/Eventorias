//
//  EventoriasUserTransformer.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/04/2025.
//

import Foundation

struct EventoriasUserTransformer {
    static func transformToViewData(_ user: EventoriasUser) -> EventoriasUserViewData {
        return EventoriasUserViewData(
            id: user.id,
            name: user.name,
            email: user.email,
            imageURL: user.imageURL,
            notificationsEnabled: user.notificationsEnabled
        )
    }
    
    static func transformToModel(_ userViewData: EventoriasUserViewData) -> EventoriasUser {
        return EventoriasUser(
            id: userViewData.id,
            name: userViewData.name,
            email: userViewData.email,
            imageURL: userViewData.imageURL,
            notificationsEnabled: userViewData.notificationsEnabled
        )
            
    }
}

