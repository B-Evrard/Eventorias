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
    
    func signIn(email: String, password: String) async -> Result<Bool, Error> {
        do {
            _ = try await auth.signIn(withEmail: email, password: password)
            return .success(true)
        }
        catch {
            print(error.localizedDescription)
            return .failure(error)
        }
        
    }
    
    func signUp(email: String, password: String, name: String) async -> Result<Bool, Error> {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return .success(true)
        }
        catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
}
