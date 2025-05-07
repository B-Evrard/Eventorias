//
//  LocationSearchProtocol.swift
//  Eventorias
//
//  Created by Bruno Evrard on 07/05/2025.
//

import Foundation
import MapKit

protocol LocationSearchProtocol {
    func getPlace(from address: AddressResult) async throws -> CLLocationCoordinate2D
}
