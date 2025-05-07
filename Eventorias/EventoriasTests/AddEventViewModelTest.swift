//
//  AddEventViewModelTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 07/05/2025.
//

import XCTest
@testable import Eventorias

final class AddEventViewModelTest: XCTestCase {

    @MainActor
    func testAddEventViewModel() async {
        
        let userManager = UserManager()
        
        let viewModel = AddEventViewModel(
            userManager: userManager,
            fireStoreService: MockFBFIreStoreService(),
            locationSearchService: MockLocationSearchService())
        
        viewModel.searchAddress("Paris Louvre")
        XCTAssertFalse(viewModel.results.isEmpty)
        
        
     }

}
