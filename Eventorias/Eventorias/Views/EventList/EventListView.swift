//
//  EventListView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct EventListView: View {
    
    @ObservedObject var viewModel: EventListViewModel
    
    @State private var selectedEvent: EventViewData?
    @State private var isShowingDetail: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    EventListSearchView(viewModel: viewModel)
                    if viewModel.isLoading {
                        Spacer()
                        ProgressViewLoading()
                        Spacer()
                    } else {
                        if (!viewModel.isError) {
                            EventListContentView(viewModel: viewModel, selectedEvent: $selectedEvent, isShowingDetail: $isShowingDetail)
                            Spacer()
                        } else {
                            ErrorView(tryAgainVisible: true, onTryAgain:
                                        {
                                Task {
                                    await self.viewModel.reloadData()
                                }
                            }
                            )
                        }
                    }
                }
                .padding(.horizontal)
                ButtonAddEvent(viewModel: viewModel)
                    .zIndex(1)
            }
            .navigationDestination(isPresented: $isShowingDetail) {
                if let event = selectedEvent {
                    EventView(viewModel: EventViewModel(event: event))
                }
            }
            .onAppear() {
                Task {
                    await viewModel.reloadData()
                }
            }
        }
    }
}

#Preview {
    //EventListView(viewModel: EventListViewModel())
}


struct ButtonAddEvent: View {
    @ObservedObject var viewModel: EventListViewModel
    @State private var isAddEvent: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: AddEventView(viewModel: AddEventViewModel(userManager: viewModel.userManager))) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color("RedEventorias"))
                        .cornerRadius(16)
                }
                .accessibilityLabel("Add new event")
                .accessibilityHint("Opens form to create new event")
                .padding(.trailing, 20)
                .padding(.bottom, 70)
            }
        }
    }
}
