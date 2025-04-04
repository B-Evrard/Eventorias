//
//  SignInView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 04/04/2025.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @Binding var isLogged: Bool
    
    var body: some View {
        VStack {
            TextField("Enter your email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Enter your password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                Task {
                    isLogged = await viewModel.login()
                    return
                }
            }
            ) {
                HStack {
                    Spacer()
                    Text("Sign in")
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
    SignInView(viewModel: viewModel, isLogged: .constant(false))
}
