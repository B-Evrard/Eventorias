//
//  MockEventGenerator.swift
//  Eventorias
//
//  Created by Bruno Evrard on 05/05/2025.
//

import Foundation
@testable import Eventorias
class MockEventGenerator {
    
    static func generateEvents() -> [Event] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy:HHmm"
        formatter.timeZone = TimeZone(identifier: "Europe/Paris")
        
        let users = ["user_1", "user_2", "user_3"]
       
        
        return [
            createEvent(
                index: 0,
                user: users[0],
                title: "Modern Art Exhibition",
                description: "Contemporary art showcase featuring emerging artists",
                category: "Exhibition",
                date: formatter.date(from: "10072025:1430") ?? Date(),
                address: ("Louvre Museum, Paris", 48.8606, 2.3376)
            ),
            createEvent(
                index: 1,
                user: users[1],
                title: "Shakespeare in the Park",
                description: "Open-air performance of Hamlet",
                category: "Theater",
                date: formatter.date(from: "01072025:1430") ?? Date(),
                address: ("Jardin du Luxembourg, Paris", 48.8462, 2.3371)
            ),
            createEvent(
                index: 2,
                user: users[2],
                title: "Summer Jazz Night",
                description: "Live jazz performances under the stars",
                category: "Concert",
                date: formatter.date(from: "08072025:1430") ?? Date(),
                address: ("Parc de la Tête d'Or, Lyon", 45.7745, 4.8519)
            ),
            createEvent(
                index: 3,
                user: users[0],
                title: "La Traviata",
                description: "Classic opera performance by Paris Opera",
                category: "Opera",
                date: formatter.date(from: "05082025:1430") ?? Date(),
                address: ("Opéra Garnier, Paris", 48.8719, 2.3316)
            ),
            createEvent(
                index: 4,
                user: users[1],
                title: "Contemporary Dance Festival",
                description: "Avant-garde dance performances",
                category: "Dance",
                date: formatter.date(from: "01102025:1430") ?? Date(),
                address: ("Maison de la Danse, Lyon", 45.7671, 4.8338)
            ),
            createEvent(
                index: 5,
                user: users[2],
                title: "AI Technology Lecture",
                description: "Keynote on future of machine learning",
                category: "Lecture",
                date: formatter.date(from: "01072025:1800") ?? Date(),
                address: ("Sorbonne University, Paris", 48.8489, 2.3435)
            ),
            createEvent(
                index: 6,
                user: users[0],
                title: "Bestseller Book Signing",
                description: "Meet the author of 'Digital Revolution'",
                category: "Book Signing",
                date: formatter.date(from: "01092025:1430") ?? Date(),
                address: ("Shakespeare & Co, Paris", 48.8523, 2.3467)
            ),
            createEvent(
                index: 7,
                user: users[1],
                title: "World Cultures Festival",
                description: "Celebration of global traditions",
                category: "Cultural Festival",
                date: formatter.date(from: "01072025:1200") ?? Date(),
                address: ("Place des Terreaux, Lyon", 45.7679, 4.8343)
            ),
            createEvent(
                index: 8,
                user: users[2],
                title: "Tech Leaders Summit",
                description: "Annual conference for tech executives",
                category: "Conference",
                date: formatter.date(from: "01122025:1430") ?? Date(),
                address: ("Station F, Paris", 48.8379, 2.3745)
            ),
            createEvent(
                index: 9,
                user: users[0],
                title: "Night Food Market",
                description: "Gourmet street food vendors",
                category: "Food Truck Event",
                date: formatter.date(from: "05072025:1430") ?? Date(),
                address: ("Vieux Port, Marseille", 43.2955, 5.3740)
            )
        ]
    }
    
    private static func createEvent(index: Int, user: String, title: String, description: String, category: String, date: Date, address: (String, Double, Double)) -> Event {
        Event(
            id: "\(index)" ,
            idUser: user,
            title: title,
            dateEvent: date,
            description: description,
            imageURL: "https://eventorias.com/img/event\(index + 1).jpg",
            addressEvent: AddressEvent(
                address: address.0,
                latitude: address.1,
                longitude: address.2
            ),
            category: category,
            titleSearch: title.uppercased()
        )
    }
}
