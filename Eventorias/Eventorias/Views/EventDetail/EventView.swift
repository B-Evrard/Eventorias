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
            VStack {
                Image("event")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 358, height: 364)
                    .background(Color("BackgroundColor"))
                    .cornerRadius(12)
                
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.white)
                        Text(viewModel.event.dateFormatter)
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.white)
                        Text(viewModel.event.timeFormatter)
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
                
                Spacer()
            }
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
    }
}

#Preview {
    let eventData = EventViewData(id: "1", title: "Art exhibition", dateEvent: Date())
    EventView(viewModel: .init(event: eventData))
    //EventView()
}
