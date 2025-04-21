//
//  LoginViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation
import FirebaseAuth

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmedPassword  = ""
    @Published var name  = ""
    
    @Published var message: String = ""
    @Published var messagePassword: Bool = false
    
    private let authService: FBAuthService
    private let fireStoreService: FBFireStore
    
    init(authService: FBAuthService = FBAuthService(), fireStoreService: FBFireStore = FBFireStore()) {
        self.authService = authService
        self.fireStoreService = fireStoreService
    }
    
    func login() async -> Bool {
#if DEBUG
        if password.isEmpty {
            password = "Bruno220865&"
            email = "be@be.fr"
        }
#endif
        
        self.message = ""
        do {
            try Control.login(email: email, password: password)
        } catch let error {
            message = error.message
            return false
        }
        
        do {
            try await authService.signIn(email: email, password: password)
        } catch {
            message = "Login failed"
            return false
        }
        
        do {
            try await APIKeyService.shared.apiKeyStorage = fireStoreService.getSecret()
            return true
        } catch {
            self.message = "An error has occured"
            return false
        }
        
    }
    
    
    func signUp() async -> Bool {
        self.message = ""
        self.messagePassword = false
        do {
            try Control.signUp(email: email, password: password, confirmedPassword: confirmedPassword, name: name)
        } catch let error {
            message = error.message
            switch error {
            case .invalidPassword:
                self.messagePassword = true
            default:
                self.messagePassword = false
            }
            return false
        }
        
        do {
            try await authService.signUp(email: email, password: password, name: name)
            
        } catch let error as NSError {
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                self.message = "Email already in use"
                return false
            default:
                self.message = error.localizedDescription
                return false
            }
        }
        
        do {
            try await APIKeyService.shared.apiKeyStorage =  fireStoreService.getSecret()
            return true
        } catch {
            self.message = "An error has occured"
            return false
        }
    }
    
    
    
}
