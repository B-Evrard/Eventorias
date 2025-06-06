//
//  EventListSearchView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 08/04/2025.
//

import SwiftUI
struct EventListSearchView: View {
    @ObservedObject var viewModel: EventListViewModel
   
    var body: some View {
        
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.callout)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                    .accessibilityHidden(true)
                
                TextField("", text: $viewModel.search, prompt: Text("Search").foregroundColor(.white))
                    .foregroundColor(.white)
                    .font(.callout)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(PlainTextFieldStyle())
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
                            await self.viewModel.reloadData()
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
                        .font(.callout)
                        .accessibilityLabel("Sort by date or category")
                        .accessibilityHint("double tap to change sorting")
                }
                .padding(8)
                .padding(.horizontal, 10)
                .background(Color("BackgroundGray"))
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
    }
}
