//
//  FBAuthService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation
import FirebaseAuth

public class FBAuthService: AuthProviding {
    
    private let auth: Auth
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }

    func signIn(withEmail email: String, password: String) async throws -> String? {
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
        return auth.currentUser?.uid
    }
    
    func signUp(withEmail email: String, password: String) async throws  -> String?  {
        _ = try await Auth.auth().createUser(withEmail: email, password: password)
        return auth.currentUser?.uid
    }
}
