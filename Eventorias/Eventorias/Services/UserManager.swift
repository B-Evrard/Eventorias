//
//  UserSession.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/04/2025.
//

import Foundation

class UserManager: ObservableObject {
    
    @Published var currentUser: EventoriasUser?
    @Published var isLogged: Bool = false
}
