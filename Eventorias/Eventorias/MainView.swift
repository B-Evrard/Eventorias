//
//  ContentView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 26/03/2025.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0

    init() {
           // Configuration globale pour UITabBar
           let tabBarAppearance = UITabBarAppearance()
           tabBarAppearance.configureWithOpaqueBackground() // Assure un fond opaque
           tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor") // Couleur de fond personnalisée
           UITabBar.appearance().standardAppearance = tabBarAppearance
           UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance // Empêche le changement lors du scroll
        
        
                tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
                tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

           // Configuration globale pour UINavigationBar
           let navigationBarAppearance = UINavigationBarAppearance()
           navigationBarAppearance.configureWithOpaqueBackground() // Assure un fond opaque
           navigationBarAppearance.backgroundColor = UIColor(named: "BackgroundColor") // Couleur de fond personnalisée
           UINavigationBar.appearance().standardAppearance = navigationBarAppearance
           UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance // Empêche le changement lors du scroll
       }
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            TabView(selection: $selection) {
                //Group {
                    EventListView()
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Events")
                        }
                        .tag(0)
                    
                    UserView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag(1)
               // }
                
            }
//            .toolbarBackground(Color("BackgroundColor"), for: .tabBar) // Couleur constante pour la TabBar
//                   .toolbarBackground(Color("BackgroundColor"), for: .navigationBar) // Couleur constante pour la NavigationBar
//                   .toolbarBackground(.visible, for: .tabBar) // Force la visibilité du fond
//                   .toolbarBackground(.visible, for: .navigationBar) // Force la visibilité du fond
            
        }
        
        
        
    }
}
#Preview {
    MainView()
}
