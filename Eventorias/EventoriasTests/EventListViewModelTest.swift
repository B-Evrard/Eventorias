//
//  EventListViewModelTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 06/05/2025.
//

import XCTest
@testable import Eventorias

final class EventListViewModelTest: XCTestCase {

    @MainActor
    func testFetchEvents() async {
        
        // Login
        let userManager = UserManager()
        let loginViewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: MockFBFIreStoreService(),
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        loginViewModel.email = mockUser.email
        loginViewModel.password = "password"
        _ = await loginViewModel.login()
        
        let eventListViewModel = EventListViewModel(
            fireStoreService: MockFBFIreStoreService()
        )
        
        let _ = await eventListViewModel.reloadData()
        XCTAssertEqual(eventListViewModel.events.count, 10)
        XCTAssertEqual(eventListViewModel.events[0].id ,"7")
        XCTAssertEqual(eventListViewModel.events[9].id ,"8")
        
        eventListViewModel.selectedSortOption = .category
        let _ = await eventListViewModel.reloadData()
        XCTAssertEqual(eventListViewModel.events.count, 10)
        XCTAssertEqual(eventListViewModel.events[0].id ,"6")
        XCTAssertEqual(eventListViewModel.events[9].id ,"1")
        
        eventListViewModel.search = "S"
        let _ = await eventListViewModel.reloadData()
        XCTAssertEqual(eventListViewModel.events.count, 2)
        
        eventListViewModel.search = "Summ"
        let _ = await eventListViewModel.reloadData()
        XCTAssertEqual(eventListViewModel.events.count, 1)
        
        eventListViewModel.search = "Summm"
        let _ = await eventListViewModel.reloadData()
        XCTAssertEqual(eventListViewModel.events.count, 0)
        
        
    }
    

}
