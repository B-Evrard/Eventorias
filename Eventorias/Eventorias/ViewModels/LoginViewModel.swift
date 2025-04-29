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
    
    private let authService: FBAuthService
    private let fireStoreService: FBFireStore
    private var userManager: UserManager
    
    
//    init(authService: FBAuthService = FBAuthService(), fireStoreService: FBFireStore = FBFireStore(), userManager: UserManager = UserManager()) {
//        self.authService = authService
//        self.fireStoreService = fireStoreService
//        self.userManager = userManager
//    }
//    
//    init(userManager: UserManager = UserManager()) {
//        self.authService = FBAuthService()
//        self.fireStoreService = FBFireStore()
//        self.userManager = userManager
//    }
    
    init(authService: FBAuthService = FBAuthService(),
         fireStoreService: FBFireStore = FBFireStore(),
         userManager: UserManager = UserManager()) {
        self.authService = authService
        self.fireStoreService = fireStoreService
        self.userManager = userManager
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
            let user = try await authService.signIn(email: email, password: password)
            guard let user = user else {
                message = "An error has occurred"
                return false
            }
            let eventoriasUser = try await fireStoreService.getUser(idAuth: user.uid)
            guard let eventoriasUser = eventoriasUser else {
                message = "An error has occurred"
                return false
            }
            userManager.currentUser = eventoriasUser
            try await APIKeyService.shared.apiKeyStorage = fireStoreService.getSecret()
        } catch let error as ControlError {
            message = error.message
            return false
        } catch  _ as NSError {
            message = "Login failed"
            return false
        } catch {
            message = "An error has occurred"
            return false
        }
        userManager.isLogged = true;
        return true
    }
    
    
    func signUp() async -> Bool {
        self.message = ""
        do {
            try Control.signUp(email: email, password: password, confirmedPassword: confirmedPassword, name: name)
            let user = try await authService.signUp(email: email, password: password, name: name)
            try await fireStoreService.addUser(user)
            userManager.currentUser = user
            try await APIKeyService.shared.apiKeyStorage =  fireStoreService.getSecret()
        } catch let error as ControlError{
            message = error.message
            return false
        } catch let error as NSError {
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                self.message = "Email already in use"
                return false
            default:
                self.message = error.localizedDescription
                return false
            }
        } catch {
            message = "An error has occurred"
            return false
        }
        userManager.isLogged = true;
        return true
       
    }
    
    private func fetchAPIKey() async throws {
            try await APIKeyService.shared.apiKeyStorage = fireStoreService.getSecret()
        }
    
}
