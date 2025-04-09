//
//  ContentView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 26/03/2025.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Group {
                EventListView(viewModel: EventListViewModel())
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
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color("BackgroundColor"), for: .tabBar)
            
        }
        .onAppear {
            selection = 0
        }
        
    }
}
#Preview {
    MainView()
}
