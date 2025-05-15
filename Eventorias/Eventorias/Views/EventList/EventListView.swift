//
//  EventListView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import SwiftUI

struct EventListView: View {
    
    @StateObject var viewModel = EventListViewModel()
    
    @State private var selectedEvent: EventViewData?
    @State private var isShowingDetail: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack {
                    
                    if viewModel.isLoading {
                        Spacer()
                        ProgressViewLoading()
                        Spacer()
                    } else {
                        if (!viewModel.isError) {
                            EventListSearchView(viewModel: viewModel)
                            EventListContentView(viewModel: viewModel, selectedEvent: $selectedEvent, isShowingDetail: $isShowingDetail)
                            Spacer()
                        } else {
                            Spacer()
                            ErrorView(tryAgainVisible: true, onTryAgain:
                                        {
                                Task {
                                    await self.viewModel.reloadData()
                                }
                            }
                            )
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
                if (!viewModel.isError) {
                    ButtonAddEvent(viewModel: viewModel)
                        .zIndex(1)
                }
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
    EventListView(viewModel: EventListViewModel())
}


struct ButtonAddEvent: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel: EventListViewModel
    @State private var isAddEvent: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: AddEventView(viewModel: AddEventViewModel(userManager: userManager))) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color("RedEventorias"))
                            .cornerRadius(16)
                    }
                    .accessibilityLabel("Add new event")
                    .accessibilityHint("Opens form to create new event")
                    .position(
                            x: geometry.size.width - 66,
                            y: geometry.size.height - 64
                        )
                }
            }
        }
    }
}
