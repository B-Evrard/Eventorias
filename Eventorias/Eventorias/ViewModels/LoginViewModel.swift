//
//  LoginViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var message: String = ""
    
    private let authService: FBAuthService
    
    init(authService: FBAuthService = FBAuthService()) {
        self.authService = authService
    }

    @MainActor
    func login() async {
        self.message = ""
        // TODO: Controle email
#if DEBUG
        if email.isEmpty {
            email = "be220865@gmail.com"
        }
#endif
        let result =  await authService.signInWithEmailLink(email: email)
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
