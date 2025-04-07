//
//  EventListView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
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
                
                List($viewModel.events, id: \.id) { $event in
                    EventRowView(event: $event)
                    
                }
                .listStyle(PlainListStyle())
                
             }
            .padding(.horizontal)
            }
        .onAppear() {
            Task {
                await self.viewModel.fetchEvents()
            }
            
        }
    }
}

#Preview {
    EventListView(viewModel: EventListViewModel())
}

