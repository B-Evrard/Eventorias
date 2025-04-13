//
//  AnnotationItem.swift
//  Eventorias
//
//  Created by Bruno Evrard on 13/04/2025.
//


import Foundation
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}