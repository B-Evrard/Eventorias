//
//  LoginViewModelTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 04/05/2025.
//

import XCTest
@testable import Eventorias

final class LoginViewModelTest: XCTestCase {
    
    @MainActor
    func testLoginFail() async {
        let authService = MockFBAuthService()
        
        let viewModel = LoginViewModel(
            authService: authService,
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
        XCTAssertEqual(viewModel.message, AppMessages.invalidPassword)
        
    }
}
