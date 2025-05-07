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
    func testValidateFail() async {
        
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        // Login
        
        let loginViewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: fireStoreService,
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        loginViewModel.email = mockUser.email
        loginViewModel.password = "password"
        _ = await loginViewModel.login()
        
        let viewModel = AddEventViewModel(
        userManager: userManager,
        fireStoreService: fireStoreService,
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
    }
    
    @MainActor
    func testValidateFBFireStoreServiceFail() async {
        
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        fireStoreService.shouldSucceed = false
        let viewModel = AddEventViewModel(
        userManager: userManager,
        fireStoreService: fireStoreService,
        locationSearchService: MockLocationSearchService())
        
        var events: [Event] = []
        do {
            events = try await fireStoreService.fetchEvents(sortBy: .date, filterBy: "")
        }
        catch {
            XCTFail("Error fetching events \(error)")
        }
        let nbEventsBefore = events.count
        
        viewModel.event.title = "Test"
        viewModel.capturedImage = UIImage(resource: .event)
        viewModel.event.category = .concert
        viewModel.event.description = "Test"
        let today = Date()
        if let datePlusOneMonth = Calendar.current.date(byAdding: .month, value: 1, to: today) {
            viewModel.event.dateEvent = datePlusOneMonth
        }
        viewModel.eventTime = "10:00"
        viewModel.event.address = "Louvre Museum, Paris"
        viewModel.adresseResult = AddressResult(title: "Louvre Museum", subtitle: "Paris")
        
        let validate = await viewModel.validate()
        XCTAssertFalse(validate)
        XCTAssertEqual(viewModel.errorMessage, AppMessages.genericError)
        
        do {
            events = try await fireStoreService.fetchEvents(sortBy: .date, filterBy: "")
        }
        catch {
            XCTFail("Error fetching events \(error)")
        }
        XCTAssertEqual(events.count, nbEventsBefore)
    }
    
    @MainActor
    func testValidateOK() async {
        
        let userManager = UserManager()
        let fireStoreService = MockFBFIreStoreService()
        // Login
        
        let loginViewModel = LoginViewModel(
            authService: MockFBAuthService(),
            fireStoreService: fireStoreService,
            userManager: userManager
        )
        
        let mockUser = MockUsers.mockUser
        loginViewModel.email = mockUser.email
        loginViewModel.password = "password"
        _ = await loginViewModel.login()
        
        let viewModel = AddEventViewModel(
        userManager: userManager,
        fireStoreService: fireStoreService,
        locationSearchService: MockLocationSearchService())
        
        var events: [Event] = []
        do {
            events = try await fireStoreService.fetchEvents(sortBy: .date, filterBy: "")
        }
        catch {
            XCTFail("Error fetching events \(error)")
        }
        let nbEventsBefore = events.count
        
        viewModel.event.title = "Test"
        viewModel.capturedImage = UIImage(resource: .event)
        viewModel.event.category = .concert
        viewModel.event.description = "Test"
        let today = Date()
        if let datePlusOneMonth = Calendar.current.date(byAdding: .month, value: 1, to: today) {
            viewModel.event.dateEvent = datePlusOneMonth
        }
        viewModel.eventTime = "10:00"
        viewModel.event.address = "Louvre Museum, Paris"
        viewModel.adresseResult = AddressResult(title: "Louvre Museum", subtitle: "Paris")
        
        let validate = await viewModel.validate()
        
        XCTAssertTrue(validate)
        XCTAssertEqual(viewModel.event.latitude, 48.8606)
        XCTAssertEqual(viewModel.event.longitude, 2.3376)
        XCTAssertEqual(viewModel.event.imageUrl, "https://eventorias.com/img/event/mock.jpg")
        do {
            events = try await fireStoreService.fetchEvents(sortBy: .date, filterBy: "")
        }
        catch {
            XCTFail("Error fetching events \(error)")
        }
        XCTAssertEqual(events.count, nbEventsBefore + 1)
    }
    
    @MainActor
    func testSearchAdresse() {
        
        
    }


}
