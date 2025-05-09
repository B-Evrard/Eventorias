//
//  UserViewModelTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 09/05/2025.
//

import XCTest
@testable import Eventorias

final class UserViewModelTest: XCTestCase {

    @MainActor
    func testInitFail() async {
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        let viewmodel = UserViewModel(userManager: userManager, fireStoreService: fireStoreService)
        XCTAssertTrue(viewmodel.errorLoadingUser)
    }
    
    @MainActor
    func testInitOK() async {
        
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        let loginViewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: fireStoreService,
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        loginViewModel.email = mockUser.email
        loginViewModel.password = "password"
        let isLogged = await loginViewModel.login()
        XCTAssertTrue(isLogged)

        let viewModel = UserViewModel(userManager: userManager, fireStoreService: fireStoreService)
        XCTAssertFalse(viewModel.errorLoadingUser)
        XCTAssertEqual(viewModel.user.email, mockUser.email)
        XCTAssertEqual(viewModel.user.name, mockUser.name)
    }
    
    @MainActor
    func testUpdatePictureOK() async {
        
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        let loginViewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: fireStoreService,
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        loginViewModel.email = mockUser.email
        loginViewModel.password = "password"
        _ = await loginViewModel.login()
        
        let viewModel = UserViewModel(userManager: userManager, fireStoreService: fireStoreService)
        viewModel.capturedImage = UIImage(resource: .event)
        let isUpdate = await viewModel.updatePicture()
        XCTAssertTrue(isUpdate)
     }
    
    @MainActor
    func testUpdateNotificationToggleOK() async {
        
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        let loginViewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: fireStoreService,
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        loginViewModel.email = mockUser.email
        loginViewModel.password = "password"
        _ = await loginViewModel.login()
        
        let viewModel = UserViewModel(userManager: userManager, fireStoreService: fireStoreService)
        viewModel.user.notificationsEnabled.toggle()
        let isNotif = viewModel.user.notificationsEnabled
        try? await Task.sleep(for: .seconds(2.1))
        _ = await loginViewModel.login()
        XCTAssertEqual(userManager.currentUser?.notificationsEnabled, isNotif)
     }
    

}
