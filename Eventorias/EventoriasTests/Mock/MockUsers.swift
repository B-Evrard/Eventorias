//
//  MockUsers.swift
//  EventoriasTests
//
//  Created by Bruno Evrard on 05/05/2025.
//

import Foundation
@testable import Eventorias

final class MockUsers {
    static let mockUsers: [EventoriasUser] = [
        EventoriasUser(
            id: "user_1",
            idAuth: "user_1",
            name: "Alice Johnson",
            email: "alice.johnson@example.com",
            imageURL: "https://eventorias.com/img/user1.jpg",
            notificationsEnabled: true
        ),
        EventoriasUser(
            id: "user_2",
            idAuth: "user_2",
            name: "Bob Smith",
            email: "bob.smith@example.com",
            imageURL: "https://eventorias.com/img/user2.jpg",
            notificationsEnabled: false
        ),
        EventoriasUser(
            id: "user_3",
            idAuth: "user_3",
            name: "Charlie Lee",
            email: "charlie.lee@example.com",
            imageURL: "https://eventorias.com/img/user3.jpg",
            notificationsEnabled: true
        )
    ]
}
