//
//  UserView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI

struct UserView: View {
    @State private var toggle: Bool = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                HStack {
                    Text("User Profile")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Image("profil")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                        .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(Color("FontGray"))
                    Text("Bruno Evrard")
                        .foregroundColor(Color("FontTextFieldGray"))
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.vertical,10)
                //.accessibilityLabel("Event Title")
                
                
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.caption)
                        .foregroundColor(Color("FontGray"))
                    Text("be&be.fr")
                        .foregroundColor(Color("FontTextFieldGray"))
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                //.accessibilityLabel("Event Title")
                
                
                
                HStack {
                    HStack {
                        ZStack(alignment: toggle ? .trailing : .leading) {
                            Capsule()
                                .fill(toggle ? Color.red : Color.gray)
                                .frame(width: 50, height: 28)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 24, height: 24)
                                .padding(2)
                        }
                        .onTapGesture { toggle.toggle() }
                        
                    }
                    
                    Text("Notifications")
                        .font(.custom("Inter-Regular", size: 20))
                        .fontWeight(.bold)
                        .lineSpacing(6)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .accessibilityHidden(true)
                    
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    UserView()
}
