//
//  SignUpView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 04/04/2025.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Binding var isLogged: Bool
    
    @State private var showInfo = false
    var body: some View {
        
        VStack {
            TextField("Enter your email", text: $viewModel.email)
                .font(.callout)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            
            SecureField("Enter your password", text: $viewModel.password)
                .font(.callout)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    Group {
                        
                        Button(action: {
                            showInfo.toggle()
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing, 5)
                        .popover(isPresented: $showInfo, arrowEdge: .bottom) {
                            Text("Password must have :\n-At least one uppercase\n-At least one digit\n-At least one lowercase\n-At least one symbol\n-Min 8 characters total")
                                .padding()
                                .presentationCompactAdaptation(.popover)
                            
                        }
                        
                        
                    }, alignment: .trailing
                )
            
            SecureField("Confirm your password", text: $viewModel.confirmedPassword)
                .font(.callout)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter your name", text: $viewModel.name)
                .font(.callout)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                Task {
                    isLogged = await viewModel.signUp()
                    return
                }
            }) {
                HStack {
                    Spacer()
                    Text("Sign up")
                        .font(.callout)
                        .foregroundColor(.white)
                        .bold(true)
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color("RedEventorias"))
                .cornerRadius(4)
            }
            .padding(.vertical, 10)
       }
    }
}

#Preview {
    let viewModel = LoginViewModel()
    SignUpView(viewModel: viewModel, isLogged: .constant(false))
}
