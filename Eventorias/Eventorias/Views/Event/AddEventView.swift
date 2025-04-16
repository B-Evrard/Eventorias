//
//  AddEventView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 14/04/2025.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = AddEventViewModel()
    
    @State private var showCalendarSheet: Bool = false
    @State private var isAdressSelected: Bool = false

    
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            VStack {
                // MARK: Zone Titre
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.caption)
                        .foregroundColor(Color("FontGray"))
                    TextField("", text: $viewModel.event.title,
                              prompt: Text("New Event ")
                            .foregroundColor(Color("FontTextFieldGray")))
                    .font(.callout)
                    .foregroundColor(Color("FontTextFieldGray"))
                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
                
                // MARK: Zone Category
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.caption)
                        .foregroundColor(Color("FontGray"))
                    
                    Menu {
                        ForEach(EventCategory.allCases) { category in
                            Button(action: {
                                viewModel.event.category = category
                            }) {
                                Text(category.displayName)
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.event.category.displayName)
                                .font(.callout)
                                .foregroundColor(Color("FontTextFieldGray"))
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color("FontTextFieldGray"))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color.clear)
                    }
                    .padding(0)
                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
                
                // MARK: Zone Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .foregroundColor(Color("FontGray"))
                        .font(.caption)
                    TextField("", text: $viewModel.event.description, prompt: Text("Tap here to enter your description ")
                            .foregroundColor(Color("FontTextFieldGray")))
                        .font(.callout)
                        .foregroundColor(Color("FontTextFieldGray"))
                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
                
                // MARK: Zone Date - Heure
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 4) {
                            Button(action: {
                                showCalendarSheet = true
                            }) {
                                Image(systemName: "calendar")
                                    .foregroundColor(Color("FontGray"))
                            }
                            
                            Text("Date")
                                .foregroundColor(Color("FontGray"))
                                .font(.caption)
                        }
                        
                        TextField(
                            "",
                            text: $viewModel.dateText,
                            prompt: Text("MM/DD/YYYY")
                                    .font(.callout)
                                    .foregroundColor(Color("FontTextFieldGray"))
                        )
                        .font(.callout)
                        .keyboardType(.numbersAndPunctuation)
                        .foregroundColor(Color("FontTextFieldGray"))
                    }
                    .padding()
                    .background(Color("BackgroundGray"))
                    .cornerRadius(4)
                    
                    .onChange(of: viewModel.dateText) { oldValue, newValue in
                        if let newDate = mmddyyyyFormatter.date(from: newValue) {
                            viewModel.event.dateEvent = newDate
                        }
                    }
                    .onChange(of: viewModel.event.dateEvent) { olsValue, newValue in
                        viewModel.dateText = mmddyyyyFormatter.string(from: newValue)
                    }
                    .sheet(isPresented: $showCalendarSheet) {
                        VStack(spacing: 16) {
                            DatePicker(
                                "Select a date",
                                selection: $viewModel.event.dateEvent,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.graphical)
                            .whiteDatePickerText()
                            .labelsHidden()
                            .padding()
                            
                            Button("Done") {
                                showCalendarSheet = false
                            }
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                        .presentationDetents([.medium])
                        .background(Color("BackgroundColor"))
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Time")
                            .font(.caption)
                            .foregroundColor(Color("FontGray"))
                        TextField(
                            "",
                            text: $viewModel.eventTime,
                            prompt: Text("HH : MM").foregroundColor(
                                Color("FontTextFieldGray")
                            )
                        )
                        .font(.callout)
                        .foregroundColor(Color("FontTextFieldGray"))
                    }
                    .padding()
                    .background(Color("BackgroundGray"))
                    .cornerRadius(4)
                }
                .padding(.horizontal)
                
                // MARK: Zone Adresse
                VStack(alignment: .leading, spacing: 8) {
                    Text("Address")
                        .font(.caption)
                        .foregroundColor(Color("FontGray"))
                    TextField(
                        "",
                        text: $viewModel.searchAddressText,
                        prompt: Text("Enter full address")
                            .font(.callout)
                            .foregroundColor(Color("FontTextFieldGray"))
                    )
                    .font(.callout)
                    .foregroundColor(Color("FontTextFieldGray"))
                    .onChange(of: viewModel.searchAddressText) {
                        if (!isAdressSelected) {
                            viewModel.searchAddress(viewModel.searchAddressText)
                        }
                        isAdressSelected = false
                    }
                        
                }
                
//                .onReceive(
//                    viewModel.$searchAddressText.debounce(
//                        for: .seconds(1),
//                        scheduler: DispatchQueue.main
//                    )
//                ) {
//                    viewModel.searchAddress($0)
//                }
                .padding()
                .background(Color("BackgroundGray"))
                .cornerRadius(4)
                .padding(.horizontal)
                
                if (!viewModel.results.isEmpty)  {
                    List(viewModel.results) { address in
                        VStack(alignment: .leading) {
                            Text(address.title)
                                .font(.callout)
                                .foregroundColor(Color("FontTextFieldGray"))
                            Text(address.subtitle)
                                .foregroundColor(Color("FontTextFieldGray"))
                                .font(.caption)
                        }
                        .onTapGesture {
                            viewModel.searchAddressText = "\(address.title), \(address.subtitle)"
                            viewModel.results.removeAll()
                            isAdressSelected = true
                        }
                        .listRowSeparatorTint(.gray)
                        .listRowBackground(Color("BackgroundGray"))
                    }
                    .frame(height: 200)
                    .padding(.horizontal)
                    .listStyle(.plain)
                }
                
                
                Spacer()
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                        
                        Text("Creation of an event")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                    }
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("BackgroundColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    var mmddyyyyFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}



#Preview {
    AddEventView()
}
