//
//  Test1.swift
//  Eventorias
//
//  Created by Bruno Evrard on 10/04/2025.
//

import SwiftUI

struct Test1: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            Text("Test 1")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    Test1()
}
