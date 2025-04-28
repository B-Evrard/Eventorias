//
//  FBAuthService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation
import FirebaseAuth

public class FBAuthService {
    
    private let auth = Auth.auth()
    
    func signIn(email: String, password: String) async throws -> User? {
        try await auth.signIn(withEmail: email, password: password)
        return Auth.auth().currentUser
        
    }
    
    func signUp(email: String, password: String, name: String) async throws  -> EventoriasUser {
        try await auth.createUser(withEmail: email, password: password)
        let userInfo = Auth.auth().currentUser
        let user = EventoriasUser(
            id: userInfo?.uid ?? "",
            name: name,
            email: email,
            imageURL: "",
            notificationsEnabled: false
        )
        return user
    }
}
