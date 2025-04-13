//
//  EventView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI

struct EventView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EventViewModel
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack (alignment: .leading) {
                Image("event")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 358, height: 364)
                    .background(Color("BackgroundColor"))
                    .cornerRadius(12)
                    .padding(.bottom,5)
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
                    Image("profil")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.horizontal)
                }
                .padding(.bottom,5)
                TextEditor(text: $viewModel.event.description)
                            .disabled(true)
                            .frame(height: lineHeight * 10)
                
                    .font(.subheadline)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .foregroundStyle(.white)
                    
                Spacer()
            }
            .padding()
        }
        //.toolbar(.hidden, for: .navigationBar)
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
        
        
    }
    
    private var lineHeight: CGFloat {
           UIFont.preferredFont(forTextStyle: .body).lineHeight + 8 // Ajustement pour le padding
       }
}

#Preview {
    let eventData = EventViewData(id: "1", title: "Art exhibition", dateEvent: Date(), description: "xxxxxx yy zzzzzzz")
    EventView(viewModel: .init(event: eventData))
    //EventView()
}
