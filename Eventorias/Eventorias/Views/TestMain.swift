//
//  TestMain.swift
//  Eventorias
//
//  Created by Bruno Evrard on 10/04/2025.
//

import SwiftUI

struct TestMain: View {
    var body: some View {
        TabView {
            Group {
                Test1()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Events")
                    }
                    
                
                UserView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                        
                    }
                    
            }
            
        }
    }
}

#Preview {
    TestMain()
}
