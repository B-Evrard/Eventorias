//
//  EventListView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct EventListView: View {
    @StateObject var viewModel: EventListViewModel
    
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            if isLoading {
                Spacer()
                ProgressView("Loading ....")
                    .tint(.white)
                    .foregroundColor(.white)
                Spacer()
            } else {
                if (!viewModel.isError) {
                    VStack {
                        EventListSearchView(viewModel: viewModel, isLoading: $isLoading)
                        List($viewModel.events, id: \.id) { $event in
                            EventRowView(event: $event)
                                .padding(.vertical,5)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color("BackgroundColor"))
                        }
                        .listStyle(PlainListStyle())
                    }
                    .padding(.horizontal)
                } else {
                    Spacer()
                    ErrorView {
                        Task {
                            isLoading = true
                            await self.viewModel.fetchEvents()
                            isLoading = false
                        }
                    }
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.addEventMock()
                        }
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 56, height: 56)
                            .background(Color("RedEventorias"))
                            .cornerRadius(16)
                }
            }
            .padding(.horizontal,5)
            .padding(.vertical,10)
            .zIndex(1)
            
        }
        .onAppear() {
            Task {
                await self.viewModel.fetchEvents()
                isLoading = false
            }
            
        }
        
    }
}

#Preview {
    EventListView(viewModel: EventListViewModel())
}



