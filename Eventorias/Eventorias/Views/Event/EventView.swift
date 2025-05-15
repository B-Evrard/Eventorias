//
//  EventView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct EventView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EventViewModel
    var body: some View {
        ZStack {
            
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            VStack  {

                WebImage(url: URL(string: viewModel.event.imageUrl )) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 358, height: 364)
                        .background(Color("BackgroundColor"))
                        .cornerRadius(12)
                        .padding(.bottom,5)
                } placeholder: {
                    ProgressView()
                        .tint(.white)
                        .frame(width: 358, height: 364)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(.white)
                            Text(viewModel.event.dateFormatter)
                                .font(.caption)
                                .foregroundStyle(.white)
                            
                        }
                        .padding(.bottom,5)
                        HStack {
                            Image(systemName: "clock")
                                .foregroundStyle(.white)
                            Text(viewModel.event.timeFormatter)
                                .font(.caption)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Spacer()
                    WebImage(url: URL(string: viewModel.event.urlPictureUser )) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding(.horizontal)
                    } placeholder: {
                        ProgressView()
                            .tint(.white)
                            .frame(width: 60, height: 60)
                    }
                }
                .padding(.bottom,5)
                
                ScrollView {
                    Text(viewModel.event.description)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 4)
                        
                }
                
                HStack(spacing: 10) {
                    Text(viewModel.event.address)
                        .font(.callout)
                        .foregroundStyle(.white)
                    Spacer()
                    
                    WebImage(url: URL(string: viewModel.mapURL())) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 72)
                            .cornerRadius(10)
                            .accessibilityLabel("Map event location")
                        
                    } placeholder: {
                        ProgressView()
                            .tint(.white)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 72)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()
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
                        
                        Text(viewModel.event.title)
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
    let eventData = EventViewData(id: "1", idUser: "",title: "Art exhibition", dateEvent: Date(), description: "Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks.Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks.Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks.", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/eventorias-47db6.firebasestorage.app/o/event_images%2F4E7EED8C-F5E4-402E-9AC3-6B264C977BD1.jpeg?alt=media&token=f705586c-c28b-4abc-96a0-255bc9b50fd6", address: "123 Rue des Métiers 60880 Jaux, France", latitude:  49.404519000000001, longitude: 2.7849428999999999, category: .exhibition, urlPictureUser: "")
    EventView(viewModel: .init(event: eventData))
    
}
