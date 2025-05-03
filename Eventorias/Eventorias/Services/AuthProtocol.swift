//
//  AuthProtocol.swift
//  Eventorias
//
//  Created by Bruno Evrard on 03/05/2025.
//


import FirebaseAuth

protocol AuthProtocol {
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResult
    var currentUser: User? { get }
}

extension Auth: AuthProtocol {}
