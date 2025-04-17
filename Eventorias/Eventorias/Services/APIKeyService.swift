//
//  APIKeyService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 17/04/2025.
//

import Foundation

final class APIKeyService {
    
    static let shared = APIKeyService()
    var apiKeyStorage = APIKeyStorage(googleMapApi: "")
    
}
