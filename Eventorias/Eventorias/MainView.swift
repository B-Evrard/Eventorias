//
//  ContentView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 26/03/2025.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    init() {
        configureTabBar()
    }
    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            TabView {
                EventListView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Events")
                            .font(.caption)
                    }
                
                UserView(viewModel: UserViewModel(userManager: userManager))
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                            .font(.caption)
                    }
                
                
                
            }
            .accessibilityLabel("Main Navigation Tab Bar")
            .accessibilityElement(children: .contain)
            
        }
    }
    
    private func configureTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
#Preview {
    MainView()
}
