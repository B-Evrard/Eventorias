//
//  UserView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: UserViewModel
    //@State private var toggle: Bool = false
    
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
                    if let urlString = viewModel.user.imageURL {
                        WebImage(url: URL(string: urlString)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .padding(.horizontal)
                        } placeholder: {
                            // Rectangle().foregroundColor(.gray)
                        }
                        .indicator(.activity) // Activity Indicator
                        .transition(.fade(duration: 0.5))
                        .frame(width: 136, height: 80)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .padding(.horizontal)
                    }
                    
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(Color("FontGray"))
                    Text(viewModel.user.name)
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
                    Text(viewModel.user.email)
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
                        ZStack(alignment: viewModel.user.notificationsEnabled ? .trailing : .leading) {
                            Capsule()
                                .fill(viewModel.user.notificationsEnabled ? Color.red : Color.gray)
                                .frame(width: 50, height: 28)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 24, height: 24)
                                .padding(2)
                        }
                        .onTapGesture { viewModel.user.notificationsEnabled.toggle()}
                        
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
    //UserView()
}
