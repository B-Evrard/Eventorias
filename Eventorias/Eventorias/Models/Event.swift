//
//  Event.swift
//  Eventorias
//
//  Created by Bruno Evrard on 02/04/2025.
//

import Foundation
import FirebaseFirestore

struct Event: Codable {
    @DocumentID var id: String?
    let title: String
    let dateEvent: Date
    let description: String
    let imageURL: String
    let adresseEvent: AdresseEvent
}


struct AdresseEvent: Codable {
    let adresse: String
    let adresse2: String
    let latitude: Double
    let longitude: Double
}
