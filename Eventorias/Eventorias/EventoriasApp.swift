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
                    LoginView(isLogged: $isLogged)
                        .transition(.move(edge: .top))
                }
            }
            .animation(.easeInOut(duration: 0.5),value: isLogged)
        }
    }
}
