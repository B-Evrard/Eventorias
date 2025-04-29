//
//  Enums.swift
//  Eventorias
//
//  Created by Bruno Evrard on 07/04/2025.
//

import Foundation

enum SortOption: String, CaseIterable {
    case date
    case category
}

enum PictureType: String, CaseIterable {
    case event
    case user
    
    var folderName: String {
        switch self {
        case .event:
            return "event_images"
        case .user:
            return "user_images"
        }
    }
}
