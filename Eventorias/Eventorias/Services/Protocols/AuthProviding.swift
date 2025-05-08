//
//  AuthProviding.swift
//  Eventorias
//
//  Created by Bruno Evrard on 03/05/2025.
//


import FirebaseAuth

protocol AuthProviding {
    
    func signIn(withEmail email: String, password: String) async throws -> String?
    func signUp(withEmail email: String, password: String) async throws -> String?
    
}


