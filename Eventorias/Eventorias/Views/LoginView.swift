//
//  LoginView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @State private var showLogin = false
    
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
                                .bold(true)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.vertical, 15)
                        .background(Color("RedEventorias"))
                        .cornerRadius(4)
                    }
                } else {
                    VStack {
                        TextField("Enter your email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            Task {
                                await viewModel.login()
                            }
                            
                        }) {
                            HStack {
                                
                                Text("Sign in")
                                    .foregroundColor(.white)
                                    .bold(true)
                                    .padding(.horizontal, 90)
                                    
                                Spacer()
                            }
                            .padding(.vertical, 15)
                            .background(Color("RedEventorias"))
                            .cornerRadius(4)
                        }
                        .padding(.vertical, 20)
                        Text(viewModel.message)
                    }
                    
                    
                }
                Spacer()
                
            }
            .padding(.horizontal,80.0)
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
