//
//  UserView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI
import SDWebImageSwiftUI
import _PhotosUI_SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: UserViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var showPhotoPicker: Bool = false
    @State private var showCamera: Bool = false
    @State private var showActionSheet = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            if (viewModel.errorLoadingUser) {
                ErrorView(tryAgainVisible: false, onTryAgain: {})
            } else  {
                VStack {
                    HStack {
                        Text("User Profile")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                        Spacer()
                        VStack {
                            if let capturedImage = viewModel.capturedImage {
                                Image(uiImage: capturedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 48, height: 48)
                                    .clipShape(Circle())
                                    .padding(.horizontal)
                            } else if let urlString = viewModel.user.imageURL {
                                WebImage(url: URL(string: urlString)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .padding(.horizontal)
                                } placeholder: {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(.white)
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .padding(.horizontal)
                                }
                                .indicator(.activity)
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
                        .onTapGesture {
                            showActionSheet = true
                        }
                        .confirmationDialog("Modifier la photo", isPresented: $showActionSheet, titleVisibility: .visible) {
                            Button("Prendre une photo") {
                                showCamera = true
                                
                            }
                            Button("Choisir dans Photos") {
                               showPhotoPicker = true
                            }
                            Button("Annuler", role: .cancel) {}
                        }
                        .sheet(isPresented: $showCamera ) {
                                CameraPicker(image: $viewModel.capturedImage)
                        }
                        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedPhoto, matching: .images)
                        .onChange(of: selectedPhoto) {
                            Task {
                                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    viewModel.capturedImage = uiImage
                                }
                            }
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
                                    .fill(viewModel.user.notificationsEnabled ? Color("RedEventorias") : Color("BackgroundGray"))
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
}

#Preview {
    //let user =  EventoriasUser(id: "1", name: "Test User", email: "test@example.com", imageURL: "", notificationsEnabled: false)
    //UserView(viewModel: UserViewModel(userManager: UserManager().currentUser = user ))
}
