//
//  MockFBAuthService.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 04/05/2025.
//

import Foundation

@testable import Eventorias

class MockFBAuthService: FBAuthProtocol {
    
    var shouldSucceed: Bool = true
    var mockUserUID: String? = "mock_uid_123"
    var usersValid = MockUsers.mockUsers
    
    func signIn(withEmail email: String, password: String) async throws -> String? {
        if let user = usersValid.first(where: { $0.email == email }) {
            return user.id
        }
        else {
            throw NSError(domain: "MockFBAuthService", code: 1, userInfo: nil) as Error
        }
    }
    
    func signUp(withEmail email: String, password: String) async throws -> String? {
        try await handleMockRequest()
    }
    
    private func handleMockRequest() async throws -> String? {
        
        if shouldSucceed {
            return mockUserUID
        }
        else {
            throw NSError(domain: "MockFBAuthService", code: 1, userInfo: nil) as Error
        }
        
    }
}
