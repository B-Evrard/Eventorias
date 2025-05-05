//
//  UserViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/04/2025.
//

import Foundation
import UIKit
import SwiftUICore

@MainActor
final class UserViewModel: ObservableObject {
    
    private let userManager: UserManager
    
    private let fireStoreService: FBFireStoreService
    
    @Published var user = EventoriasUserViewData(id: "",idAuth: "", name: "", email: "", imageURL: "", notificationsEnabled: false)
    @Published var errorLoadingUser = false
    @Published var capturedImage: UIImage?
    
    init(userManager: UserManager, fireStoreService: FBFireStoreService = FBFireStoreService()) {
        self.userManager = userManager
        self.fireStoreService = fireStoreService
        loadUser()
    }
    
    func validate() async -> Bool {
        
        if let capturedImage = capturedImage {
            do {
                let imageUrl = try await fireStoreService.uploadImage(capturedImage, type: .user)
                user.imageURL = imageUrl
            }
            catch {
                //showError = true
                //errorMessage = "An error has occured"
            }
        }
        
        //self.isValidating = true
        do {
            try await fireStoreService.updateUser(EventoriasUserTransformer.transformToModel(user))
            
        }
        catch {
            //showError = true
            //errorMessage = "An error has occured"
        }
        return true
    }
    
    private func loadUser() {
        guard let currentUser = userManager.currentUser else {
            self.errorLoadingUser = true
            return
        }
        self.user = EventoriasUserTransformer.transformToViewData(currentUser)
    }
    
}
