//
//  UserSession.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/04/2025.
//

import Foundation

final class UserSession {
    static let shared = UserSession()
    var user: EventoriasUser?
}
