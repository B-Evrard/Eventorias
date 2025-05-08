//
//  MockFBAuthService.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 04/05/2025.
//

import Foundation

@testable import Eventorias
import FirebaseAuth

class MockFBAuthService: AuthProviding {
    
    var shouldSucceed: Bool = true
    var mockUserUID: String? = "mock_uid_123"
    var usersValid = MockUsers.mockUsers
    
    func signIn(withEmail email: String, password: String) async throws -> String? {
        if shouldSucceed {
            if let user = usersValid.first(where: { $0.email == email }) {
                return user.id
            }
            else {
                throw AuthErrorCode.invalidCredential
            }
        }
        else
        {
            return nil
        }
        
    }
    
    func signUp(withEmail email: String, password: String) async throws -> String? {
        if shouldSucceed {
            if usersValid.first(where: { $0.email == email }) != nil {
                throw AuthErrorCode.emailAlreadyInUse
            }
            else {
                return mockUserUID
            }
        } else {
            return nil
        }
    }
    
    
}
