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
    
    private let authService: FBAuthService
    
    init(authService: FBAuthService = FBAuthService()) {
        self.authService = authService
    }

    @MainActor
    func login() async {
        self.message = ""
        // TODO: Controle email
        
        // TODO: Control Password
#if DEBUG
        if email.isEmpty {
            email = "be220865@gmail.com"
        }
#endif
        let result =  await authService.signIn(email: email, password: password)
        switch result {
        case .success:
            message = "Login successfull"
            print("Login successfull: \(email)")
        case .failure(let error):
            message = "Login failed: \(error)"
            print("Login failed: \(error)")
        }
    }
    
    @MainActor
    func signUp() async {
        self.message = ""
        // TODO: Controle email
        
        // TODO: Control Password
        
        // TODO: Control Name
#if DEBUG
        if email.isEmpty {
            email = "be220865@gmail.com"
        }
#endif
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
