//
//  EventListContentView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI
struct EventListContentView: View {
    
    @ObservedObject var viewModel: EventListViewModel
    @State private var selectedEvent: EventViewData?
    @State private var isShowingDetail: Bool = false
    
    var body: some View {
        List($viewModel.events, id: \.id) { $event in
            EventRowView(event: $event)
                .padding(.vertical,5)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color("BackgroundColor"))
                .listRowSeparator(.hidden)
                .onTapGesture {
                    selectedEvent = event
                    isShowingDetail = true
                }
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .navigationDestination(isPresented: $isShowingDetail) {
            if let event = selectedEvent {
                EventView()
            }
        }
        
    }
}
