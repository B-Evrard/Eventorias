//
//  EventoriasApp.swift
//  Eventorias
//
//  Created by Bruno Evrard on 26/03/2025.
//

import SwiftUI

@main
struct EventoriasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if userManager.isLogged {
                    MainView()
                } else {
                    LoginView(viewModel: LoginViewModel(userManager: userManager))
                        .transition(.move(edge: .top))
                }
            }
            .animation(.easeInOut(duration: 0.5),value: userManager.isLogged)
            .environmentObject(userManager)
        }
    }
}
