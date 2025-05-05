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
    
    private let authService: FBAuthProtocol
    private let fireStoreService: FBFireStoreProtocol
    private var userManager: UserManager

    init(authService: FBAuthProtocol = FBAuthService(),
         fireStoreService: FBFireStoreProtocol = FBFireStoreService(),
         userManager: UserManager = UserManager()) {
        self.authService = authService
        self.fireStoreService = fireStoreService
        self.userManager = userManager
    }
    
    func login() async -> Bool {
#if DEBUG
//        if password.isEmpty {
//            password = "Bruno220865&"
//            email = "be@be.fr"
//        }
#endif
        
        self.message = ""
        do {
            try Control.login(email: email, password: password)
            let id = try await authService.signIn(withEmail: email, password: password)
            guard let id = id else {
                message = AppMessages.genericError
                return false
            }
            let eventoriasUser = try await fireStoreService.getUserByIdAuth(idAuth: id)
            guard let eventoriasUser = eventoriasUser else {
                message = AppMessages.genericError
                return false
            }
            userManager.currentUser = eventoriasUser
            try await APIKeyService.shared.apiKeyStorage = fireStoreService.getSecret()
        } catch let error as ControlError {
            message = error.message
            return false
        } catch  _ as NSError {
            message = AppMessages.loginFailed
            return false
        } catch {
            message = AppMessages.genericError
            return false
        }
        userManager.isLogged = true;
        return true
    }
    
    
    func signUp() async -> Bool {
        self.message = ""
        do {
            try Control.signUp(email: email, password: password, confirmedPassword: confirmedPassword, name: name)
            let id = try await authService.signUp(withEmail: email, password: password )
            guard let id = id else {
                message = "An error has occurred"
                return false
            }
            var eventoriasUser = EventoriasUser(
                id: "",
                idAuth: id,
                name: name,
                email: email,
                imageURL: "",
                notificationsEnabled: false
            )
            let idEventoriasUser = try await fireStoreService.addUser(eventoriasUser)
            eventoriasUser.id = idEventoriasUser
            userManager.currentUser = eventoriasUser
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
