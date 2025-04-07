//
//  EventListView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel
    
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
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 8)
                                .accessibilityHidden(true)
                            
                            TextField("", text: $viewModel.search, prompt: Text("Search").foregroundColor(.white))
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .accessibilityLabel("Search events")
                                .accessibilityHint("Enter text to filter events")
                        }
                        .padding(8)
                        .background(Color("BackgroundGray"))
                        .cornerRadius(20)
                        Menu {
                            ForEach(SortOption.allCases , id: \.self) { option in
                                Button {
                                    viewModel.selectedSortOption = option
                                    Task {
                                        isLoading = true
                                        await self.viewModel.fetchEvents()
                                        isLoading = false
                                    }
                                    
                                } label: {
                                    HStack {
                                        if viewModel.selectedSortOption == option {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                        Text(option.rawValue)
                                            .foregroundColor(viewModel.selectedSortOption == option ? .blue : .black)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .accessibilityHidden(true)
                                
                                Text("Sorting")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                    .accessibilityLabel("Sort")
                                    .accessibilityHint("Enter text to filter events")
                            }
                            .padding(8)
                            .padding(.horizontal, 10)
                            .background(Color("BackgroundGray"))
                            .cornerRadius(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        List($viewModel.events, id: \.id) { $event in
                            EventRowView(event: $event)
                            
                            
                        }
                        .listStyle(PlainListStyle())
                    }.padding(.horizontal)
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

