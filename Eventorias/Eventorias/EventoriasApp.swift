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
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }
}
