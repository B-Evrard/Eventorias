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
                
                List {
                    ForEach(1...10, id: \.self) { i in
                        VStack  {
                            HStack {
                                Image("profil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .padding(.horizontal)
                                
                                VStack  {
                                    Text("Music festival")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                        .padding(.vertical,5)
                                    Text("June 15, 2024")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                Spacer()
                                Image("event")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 136, height: 80)
                                    .background(Color("BackgroundColor"))
                                    .cornerRadius(12)
                            }
                            .background(Color("BackgroundGray"))
                            .cornerRadius(12)
                            
                        }
                        .padding(.vertical,5)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color("BackgroundColor"))
                    }
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
