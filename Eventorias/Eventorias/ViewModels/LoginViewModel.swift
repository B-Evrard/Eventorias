//
//  LoginViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmedPassword  = ""
    @Published var name  = ""
    
    @Published var message: String = ""
    @Published var messagePassword: Bool = false
    
    
    private let authService: FBAuthService
    
    init(authService: FBAuthService = FBAuthService()) {
        self.authService = authService
    }

    @MainActor
    func login() async {
        self.message = ""
        do {
            try Control.login(email: email, password: password)
        } catch let error {
            message = error.message
            return
        }

        let result =  await authService.signIn(email: email, password: password)
        switch result {
        case .success:
            message = "Login successfull"
            print("Login successfull: \(email)")
        case .failure(let error):
            message = "Login failed"
            print("Login failed: \(error)")
        }
    }
    
    @MainActor
    func signUp() async {
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
           
            return
        }
        let result =  await authService.signUp(email: email, password: password, name: name)
        switch result {
        case .success:
            message = "Login successfull"
            print("Login successfull: \(email)")
        case .failure(let error):
            message = "Login failed: \(error)"
            print("Login failed: \(error)")
        }
    }
}
