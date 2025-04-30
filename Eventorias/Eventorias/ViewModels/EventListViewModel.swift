//
//  EventListViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 01/04/2025.
//

import Foundation

@MainActor
final class EventListViewModel: ObservableObject {
        
    private let fireStoreService: FBFireStore
    @Published var userManager: UserManager
    
    @Published var search: String = ""
    @Published var events: [EventViewData] = []
    @Published var selectedSortOption: SortOption = .date
    @Published var isError: Bool = false
    @Published var isLoading = false
    
    
    init(userManager: UserManager, fireStoreService: FBFireStore = FBFireStore()) {
        self.userManager = userManager
        self.fireStoreService = fireStoreService
    }
    
    func reloadData() async {
        isLoading = true
        await fetchEvents()
        isLoading = false
    }
    
    func fetchEvents() async  {
        do {
            self.isError = false
            let events = try await fireStoreService.fetchEvents(sortBy: selectedSortOption, filterBy: search)
            var viewDataList: [EventViewData] = []
            for event in events {
                var viewData = EventTransformer.transformToViewData(event)
                do {
                    let user = try await fireStoreService.getUser(id: viewData.idUser)
                    viewData.urlPictureUser = user?.imageURL ?? ""
                } catch {
                    viewData.urlPictureUser = ""
                }
                viewDataList.append(viewData)
            }
            self.events = viewDataList
        } catch {
            self.isError = true
        }
    }
    
    
}
