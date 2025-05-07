//
//  AddEventViewModelTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 07/05/2025.
//

import XCTest
@testable import Eventorias
import MapKit

final class AddEventViewModelTest: XCTestCase {

    @MainActor
    func testAddEventViewModel() async {
        
        let userManager = UserManager()
        
        let viewModel = AddEventViewModel(
        userManager: userManager,
        fireStoreService: MockFBFIreStoreService(),
        locationSearchService: MockLocationSearchService())
        
        var validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.titleEmpty)
        
        viewModel.event.title = "Test"
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.categoryEmpty)
        
        viewModel.event.category = .concert
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.descriptionEmpty)
        
        viewModel.event.description = "Test"
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.dateNotInFuture)
        
        
        let today = Date()
        if let datePlusOneMonth = Calendar.current.date(byAdding: .month, value: 1, to: today) {
            viewModel.event.dateEvent = datePlusOneMonth
            viewModel.eventTime = "xx:xx"
        }
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.hourError)
        
        viewModel.eventTime = "10:00"
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.adressEmpty)
        
        viewModel.event.address = "Louvre Museum, Paris"
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.adressEmpty)
        
        viewModel.adresseResult = AddressResult(title: "Louvre Museum", subtitle: "Paris")
        validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.pictureEmpty)
        
        viewModel.capturedImage = UIImage(resource: .event)
        validate = await viewModel.validate()
        XCTAssertTrue(validate)
        XCTAssertEqual(viewModel.event.latitude, 48.8606)
        XCTAssertEqual(viewModel.event.longitude, 2.3376)
        XCTAssertEqual(viewModel.event.imageUrl, "https://eventorias.com/img/event/mock.jpg")
        
        
     }
    
    


}
