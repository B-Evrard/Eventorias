//
//  EventListViewModel.swift
//  Eventorias
//
//  Created by Bruno Evrard on 01/04/2025.
//

import Foundation
import Combine

@MainActor
final class EventListViewModel: ObservableObject {
        
    private let fireStoreService: FBFireStoreService
     
    @Published var search: String = ""
    @Published var events: [EventViewData] = []
    @Published var selectedSortOption: SortOption = .date
    @Published var isError: Bool = false
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(fireStoreService: FBFireStoreService = FBFireStoreService()) {
        self.fireStoreService = fireStoreService
        $search
            .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                Task {
                    await self?.reloadData()
                }
            }
            .store(in: &cancellables)
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
                    let user = try await fireStoreService.getUserById(id: viewData.idUser)
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
