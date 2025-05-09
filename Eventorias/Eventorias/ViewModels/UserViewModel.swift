//
//  UserViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/04/2025.
//

import Foundation
import UIKit
import SwiftUICore
import Combine

@MainActor
final class UserViewModel: ObservableObject {
    
    private let userManager: UserManager
    private let fireStoreService: FBFireStoreService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user = EventoriasUserViewData(id: "",idAuth: "", name: "", email: "", imageURL: "", notificationsEnabled: false)
    @Published var errorLoadingUser = false
    @Published var capturedImage: UIImage?
    @Published var errorMessage = ""
    
    
    init(userManager: UserManager, fireStoreService: FBFireStoreService = FBFireStoreService()) {
        self.userManager = userManager
        self.fireStoreService = fireStoreService
        loadUser()
        
        $user
            .map { $0.notificationsEnabled }
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                Task {
                    _ = await self.Validate()
                }
            }
            .store(in: &cancellables)
    }
    
    func updatePicture() async -> Bool {
        errorMessage = ""
        if let capturedImage = capturedImage {
            do {
                let imageUrl = try await fireStoreService.uploadImage(capturedImage, type: .user)
                user.imageURL = imageUrl
            }
            catch {
                errorMessage = AppMessages.genericError
                return false
            }
        }
        return await Validate()
    }
    
    private func Validate() async -> Bool {
        errorMessage = ""
        do {
            try await fireStoreService.updateUser(EventoriasUserTransformer.transformToModel(user))
        }
        catch {
            errorMessage = AppMessages.genericError
            return false
        }
        return true
    }
    
    private func loadUser() {
        guard let currentUser = userManager.currentUser else {
            self.errorLoadingUser = true
            return
        }
        self.errorLoadingUser = true
        self.user = EventoriasUserTransformer.transformToViewData(currentUser)
    }
    
}
