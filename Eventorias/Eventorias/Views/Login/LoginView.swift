//
//  LoginView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @Binding var isLogged: Bool
    
    @State private var showLogin = false
    @State private var isSignUp = false
    
    var body: some View {
        ZStack {
            
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 242,
                        height: 120
                    )
                    .padding(.top, 180)
                    .padding(.bottom, 40)
                    .accessibilityLabel("Eventorias logo")
                
                if (!showLogin) {
                    Button(action: {
                        showLogin = true
                        
                    }) {
                        HStack {
                            Image("Envelope")
                                .resizable()
                                .frame( width: 23,
                                        height: 18)
                                .padding(.leading, 20)
                                .accessibilityHidden(true)
                            Text("Sign in with email")
                                .foregroundColor(.white)
                                .font(.callout)
                                .bold(true)
                                .padding(.leading, 20)
                                .accessibilityHidden(true)
                            Spacer()
                        }
                        .padding(.vertical, 15)
                        .background(Color("RedEventorias"))
                        .cornerRadius(4)
                    }
                    .accessibilityLabel("Sign in with email")
                    .accessibilityHint("Tap to sign in with email")
                } else {
                    if(!isSignUp) {
                        SignInView(viewModel: viewModel, isLogged: $isLogged)
                    } else {
                        SignUpView(viewModel: viewModel, isLogged: $isLogged)
                    }
                    Button(action: {
                        isSignUp.toggle()
                    }) {
                        Text(isSignUp ? "Have an account? Sign in" : "Don't have an account? Sign up")
                            .font(.callout)
                            .foregroundColor(.blue)
                            .accessibilityLabel(isSignUp ? "Have an account? Sign in" : "Don't have an account? Sign up")
                            .accessibilityHint(isSignUp ? "Tap to sign in" : "Tap to sign up")
                    }
                    .padding(.vertical, 10)
                    
                }
                Spacer()
                
                Text(viewModel.message)
                    .foregroundColor(.red)
                    .font(.callout)
            }
            .padding(.horizontal,80.0)
            
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(), isLogged: .constant(false))
    
    
}
