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
    
    @ScaledMetric private var envelopeWidth: CGFloat = 23
    @ScaledMetric private var envelopeHeight: CGFloat = 18
    
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
                
                if (!showLogin) {
                    Button(action: {
                        showLogin = true
                        
                    }) {
                        HStack {
                            Image("Envelope")
                                .resizable()
                                .frame( width: envelopeWidth,
                                        height: envelopeWidth)
                                .padding(.leading, 20)
                            Text("Sign in with email")
                                .foregroundColor(.white)
                                .font(.callout)
                                .bold(true)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.vertical, 15)
                        .background(Color("RedEventorias"))
                        .cornerRadius(4)
                    }
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
