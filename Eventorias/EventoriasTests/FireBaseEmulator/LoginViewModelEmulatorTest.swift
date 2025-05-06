//
//  LoginViewModelEmulatorTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 06/05/2025.
//

import XCTest
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
@testable import Eventorias

final class LoginViewModelEmulatorTest: XCTestCase {
    
    @MainActor
    func testSignUp() async {
        
        Firestore.firestore().useEmulator(withHost: "localhost", port: 8080)
        let settings = Firestore.firestore().settings
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        Storage.storage().useEmulator (withHost:"localhost",port: 9199)
        
        let auth = Auth.auth()
        auth.useEmulator(withHost: "localhost", port: 9099)
        
        let authService = FBAuthService(auth: auth)
        
        let userManager = UserManager()
        
        let viewModel = LoginViewModel(
            authService: authService,
            fireStoreService: FBFireStoreService(),
            userManager: userManager
        )
        
        viewModel.email = ""
        viewModel.password = ""
        viewModel.confirmedPassword = ""
        viewModel.name = ""
        
        var isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.emailEmpty)
        
        viewModel.email = "hhhh"
        isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.invalidFormatMail)
        
        viewModel.email = "be@be.fr"
        isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.passwordEmpty)
        
        viewModel.email = "be@be.fr"
        viewModel.password = "password"
        isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.invalidPassword)
        
        viewModel.email = "be@be.fr"
        viewModel.password = "Bruno220865&"
        viewModel.confirmedPassword = ""
        isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.passwordNotMatch)
        
        viewModel.email = "be@be.fr"
        viewModel.password = "Bruno220865&"
        viewModel.confirmedPassword = "Bruno220865&"
        isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.nameEmpty)
        
        viewModel.email = "be@be.fr"
        viewModel.password = "Bruno220865&"
        viewModel.confirmedPassword = "Bruno220865&"
        viewModel.name = "Bruno"
        
        isLogged = await viewModel.signUp()
        
        XCTAssertTrue(isLogged)
        XCTAssertTrue(userManager.isLogged)
        XCTAssertEqual(userManager.currentUser?.email, "be@be.fr")
        XCTAssertEqual(userManager.currentUser?.name, "Bruno")
        XCTAssertEqual(userManager.currentUser?.notificationsEnabled, false)
        
        //        let mockUser = MockUsers.mockUser
        //        viewModel.email = mockUser.email
        //        viewModel.password = "Bruno220865&"
        //        viewModel.confirmedPassword = "Bruno220865&"
        //        viewModel.name = mockUser.name
        //
        //        isLogged = await viewModel.signUp()
        //        XCTAssertFalse(isLogged)
        //        XCTAssertEqual(viewModel.message, AppMessages.emailAlreadyExists)
        
    }
    
    
    @MainActor
    func testLoginFail() async {
        
        Firestore.firestore().useEmulator(withHost: "localhost", port: 8080)
        let settings = Firestore.firestore().settings
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        Storage.storage().useEmulator (withHost:"localhost",port: 9199)

        let auth = Auth.auth()
        auth.useEmulator(withHost: "localhost", port: 9099)
        
        let authService = FBAuthService(auth: auth)
        
        let viewModel = LoginViewModel(
            authService: authService,
            fireStoreService: FBFireStoreService(),
            userManager: UserManager()
        )
        
        viewModel.email = ""
        viewModel.password = ""
        var isLogged = await viewModel.login()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.emailEmpty)
        
        viewModel.email = "hhhh"
        isLogged = await viewModel.login()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.invalidFormatMail)
        
        viewModel.email = "be@be.fr"
        isLogged = await viewModel.login()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.passwordEmpty)
        
        viewModel.email = "be@be.fr"
        viewModel.password = "password"
        isLogged = await viewModel.login()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.loginFailed)
        
    }

}
