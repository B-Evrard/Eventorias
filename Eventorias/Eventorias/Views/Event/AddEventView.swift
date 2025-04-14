//
//  AddEventView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 14/04/2025.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                        
                        Text("Creation of an event")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                    }
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("BackgroundColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AddEventView()
}
