//
//  EventListContentView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 09/04/2025.
//

import SwiftUI
struct EventListContentView: View {
    
    @ObservedObject var viewModel: EventListViewModel
    @Binding  var selectedEvent: EventViewData?
    @Binding  var isShowingDetail: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($viewModel.events, id: \.self) { $event in
                    Button {
                        selectedEvent = event
                        isShowingDetail = true
                    } label: {
                        EventRowView(event: $event)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color("BackgroundColor"))
                    .listRowSeparator(.hidden)
                    .accessibilityLabel(event.accessibilityLabel)
                    .accessibilityHint("Double tap to view event details")
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                
            }
            
        }
    }
}

