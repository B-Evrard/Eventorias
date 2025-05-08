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
    
    private let authService: AuthProviding
    private let fireStoreService: DataStore
    private var userManager: UserManager

    init(authService: AuthProviding = FBAuthService(),
         fireStoreService: DataStore = FBFireStoreService(),
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
        } catch  let error as NSError {
            if let errorCode = AuthErrorCode(rawValue: error.code) {
                switch errorCode {
                case .invalidCredential, .wrongPassword, .userNotFound:
                    message = AppMessages.loginFailed
                default:
                    message = AppMessages.genericError
                }
                return false
            } else {
                message = AppMessages.genericError
                return false
            }
           
        } //catch {
//            message = AppMessages.genericError
//            return false
//        }
        userManager.isLogged = true;
        return true
    }
    
    
    func signUp() async -> Bool {
        self.message = ""
        do {
            try Control.signUp(email: email, password: password, confirmedPassword: confirmedPassword, name: name)
            let id = try await authService.signUp(withEmail: email, password: password )
            guard let id = id else {
                message = AppMessages.genericError
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
                self.message = AppMessages.emailAlreadyExists
                return false
            default:
                self.message = AppMessages.genericError
                return false
            }
        } catch {
            message = AppMessages.genericError
            return false
        }
        userManager.isLogged = true;
        return true
       
    }
}
