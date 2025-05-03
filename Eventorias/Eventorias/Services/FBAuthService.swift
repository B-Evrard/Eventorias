//
//  FBAuthService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation
import FirebaseAuth

public class FBAuthService {
    
    private let auth: AuthProtocol
    init(auth: AuthProtocol = Auth.auth()) {
            self.auth = auth
        }

    func signIn(email: String, password: String) async throws -> User? {
            _ = try await auth.signIn(withEmail: email, password: password)
            return auth.currentUser
        }
    
    func signUp(email: String, password: String) async throws  -> User?  {
        _ = try await auth.createUser(withEmail: email, password: password)
        return auth.currentUser
    }
}
