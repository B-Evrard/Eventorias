//
//  AddEventView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 14/04/2025.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    @State var nom: String = ""
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .foregroundColor(Color("FontGray"))
                    TextField("", text: $nom, prompt: Text("New Event ").foregroundColor(Color("FontTextFieldGray")))
                        .foregroundColor(Color("FontTextFieldGray"))
                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .foregroundColor(Color("FontGray"))
                    TextField("", text: $nom, prompt: Text("Tap here to enter your description ").foregroundColor(Color("FontTextFieldGray")))
                        .foregroundColor(Color("FontTextFieldGray"))
                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date")
                            .foregroundColor(Color("FontGray"))
                        TextField(
                            "",
                            text: $nom,
                            prompt: Text(
                                "MM/DD/YYYY"
                            ).foregroundColor(Color("FontTextFieldGray"))
                        )
                        .foregroundColor(Color("FontTextFieldGray"))
                    }
                    .padding()
                    .background(Color("BackgroundGray"))
                    .cornerRadius(4)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Time")
                            .foregroundColor(Color("FontGray"))
                        TextField(
                            "",
                            text: $nom,
                            prompt: Text("HH : MM").foregroundColor(
                                Color("FontTextFieldGray")
                            )
                        )
                        .foregroundColor(Color("FontTextFieldGray"))
                    }
                    .padding()
                    .background(Color("BackgroundGray"))
                    .cornerRadius(4)
                }
                .padding(.horizontal)
                  
                VStack(alignment: .leading, spacing: 8) {
                    Text("Adress")
                        .foregroundColor(Color("FontGray"))
                    TextField("", text: $nom, prompt: Text("Enter full address").foregroundColor(Color("FontTextFieldGray")))
                        .foregroundColor(Color("FontTextFieldGray"))
                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
            }
  
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
