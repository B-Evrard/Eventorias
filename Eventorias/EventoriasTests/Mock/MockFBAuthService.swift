//
//  MockFBAuthService.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 04/05/2025.
//

import Foundation

@testable import Eventorias

class MockFBAuthService: FBAuthServiceProtocol {
    
    var shouldSucceed: Bool = true
    var mockUserUID: String? = "mock_uid_123"
    
    func signIn(withEmail email: String, password: String) async throws -> String? {
        try await handleMockRequest()
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
