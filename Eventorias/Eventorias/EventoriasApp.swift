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
    
    @State var isLogged: Bool = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLogged {
                    MainView()
                } else {
                    LoginView(viewModel: LoginViewModel(), isLogged: $isLogged)
                    .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                                                    removal: .move(edge: .top).combined(with: .opacity)))
                    
                }
            }.animation(.easeInOut(duration: 1), value: UUID())
           
        }
    }
    
    
   
}
