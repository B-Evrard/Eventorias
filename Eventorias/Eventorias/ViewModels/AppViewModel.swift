//
//  AppViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 01/04/2025.
//


import Foundation

class AppViewModel: ObservableObject {
    @Published var isLogged: Bool
    
    //let tokenManager: TokenManager
    
    init() {
        self.isLogged = false
        //self.tokenManager = TokenManager.shared
    }
    
    
}
