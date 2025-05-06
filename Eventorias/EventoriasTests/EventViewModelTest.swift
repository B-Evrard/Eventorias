//
//  EventViewModelTest.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 06/05/2025.
//

import XCTest
@testable import Eventorias

final class EventViewModelTest: XCTestCase {

    func testEventViewModel() {
        
        
        
        let events = MockEventGenerator.generateEvents()
        if let event = events.first {
            let eventViewData = EventTransformer.transformToViewData(event)
            let viewModel = EventViewModel(event: eventViewData)
            
            APIKeyService.shared.apiKeyStorage.googleMapApi = "mockKey"
            
            let urlGoogleMap = String.googleStaticMapURL(
                latitude: event.addressEvent.latitude,
                longitude: event.addressEvent.longitude,
                apiKey: APIKeyService.shared.apiKeyStorage.googleMapApi
            )
            
            XCTAssertEqual(viewModel.mapURL(), urlGoogleMap)
            
        }
    }
    
    
     

}
