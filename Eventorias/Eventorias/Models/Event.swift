//
//  Event.swift
//  Eventorias
//
//  Created by Bruno Evrard on 02/04/2025.
//

import Foundation
import FirebaseFirestore

struct Event: Decodable {
    @DocumentID var id: String?
    let title: String
    let dateEvent: Date
    //let description: String
    
}
