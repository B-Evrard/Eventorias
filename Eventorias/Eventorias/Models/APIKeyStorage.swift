//
//  secret.swift
//  Eventorias
//
//  Created by Bruno Evrard on 17/04/2025.
//

import Foundation
import FirebaseFirestore

struct APIKeyStorage: Codable {
    @DocumentID var id: String?
    let googleMapApi: String
}
