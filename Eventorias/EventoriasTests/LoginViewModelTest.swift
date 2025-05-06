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
        
        let viewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: MockFBFIreStoreService(),
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
    
    @MainActor
    func testLoginAuthServiceFail() async {
        
        let authServiceMock = MockFBAuthService()
        authServiceMock.shouldSucceed = false
        
        let viewModel = LoginViewModel(
            authService: authServiceMock,
            fireStoreService: MockFBFIreStoreService(),
            userManager: UserManager()
        )
        
        let mockUser = MockUsers.mockUser
        viewModel.email = mockUser.email
        viewModel.password = "password"
        let isLogged = await viewModel.login()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.genericError)
        
    }
    
    @MainActor
    func testLoginFBUSerFail() async {
        
        let fireStoreService = MockFBFIreStoreService()
        fireStoreService.shouldSucceed = false
        
        let viewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: fireStoreService,
            userManager: UserManager()
        )
        
        let mockUser = MockUsers.mockUser
        viewModel.email = mockUser.email
        viewModel.password = "password"
        let isLogged = await viewModel.login()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.genericError)
        
        
    }
    
    
    @MainActor
    func testLoginOk() async {
        let userManager = UserManager()
        let viewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: MockFBFIreStoreService(),
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        viewModel.email = mockUser.email
        viewModel.password = "password"
        let isLogged = await viewModel.login()
        XCTAssertTrue(isLogged)
        
        XCTAssertTrue(userManager.isLogged)
        XCTAssertEqual(userManager.currentUser?.id, mockUser.id)
        XCTAssertEqual(userManager.currentUser?.email, mockUser.email)
        XCTAssertEqual(userManager.currentUser?.name, mockUser.name)
        XCTAssertEqual(userManager.currentUser?.imageURL, mockUser.imageURL)
        XCTAssertEqual(userManager.currentUser?.notificationsEnabled, mockUser.notificationsEnabled)
        
    }
    
    @MainActor
    func testSignUpFail() async {
        
        let viewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: MockFBFIreStoreService(),
            userManager: UserManager()
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
        
        let mockUser = MockUsers.mockUser
        viewModel.email = mockUser.email
        viewModel.password = "Bruno220865&"
        viewModel.confirmedPassword = "Bruno220865&"
        viewModel.name = mockUser.name
        
        isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.emailAlreadyExists)
    }
    
    @MainActor
    func testSignUpAuthServiceFail() async {
        
        let authServiceMock = MockFBAuthService()
        authServiceMock.shouldSucceed = false
        
        let viewModel = LoginViewModel(
            authService: authServiceMock,
            fireStoreService: MockFBFIreStoreService(),
            userManager: UserManager()
        )
        
        viewModel.email = "be@be.fr"
        viewModel.password = "Bruno220865&"
        viewModel.confirmedPassword = "Bruno220865&"
        viewModel.name = "Bruno"
        
        let isLogged = await viewModel.signUp()
        XCTAssertFalse(isLogged)
        XCTAssertEqual(viewModel.message, AppMessages.genericError)
        
    }
    
    @MainActor
    func testSignUpOk() async {
        
        let userManager = UserManager()
        
        let viewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: MockFBFIreStoreService(),
            userManager: userManager
        )
        
        viewModel.email = "be@be.fr"
        viewModel.password = "Bruno220865&"
        viewModel.confirmedPassword = "Bruno220865&"
        viewModel.name = "Bruno"
        
        let isLogged = await viewModel.signUp()
        
        XCTAssertTrue(isLogged)
        XCTAssertTrue(userManager.isLogged)
        XCTAssertEqual(userManager.currentUser?.email, "be@be.fr")
        XCTAssertEqual(userManager.currentUser?.name, "Bruno")
        XCTAssertEqual(userManager.currentUser?.notificationsEnabled, false)
        
    }
}
