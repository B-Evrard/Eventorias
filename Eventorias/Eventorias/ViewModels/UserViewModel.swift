//
//  UserViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/04/2025.
//

import Foundation
import UIKit

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published private var userManager: UserManager
    @Published var user = EventoriasUserViewData(id: "", name: "", email: "", imageURL: "", notificationsEnabled: false)
    @Published var errorLoadingUser = false
    @Published var capturedImage: UIImage?
    
    init(userManager: UserManager) {
        self.userManager = userManager
        loadUser()
    }
    
    private func loadUser() {
        guard let currentUser = userManager.currentUser else {
            self.errorLoadingUser = true
            return
        }
        self.user = EventoriasUserTransformer.transformToViewData(currentUser)
    }
    
}
