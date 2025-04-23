//
//  AddEventView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 14/04/2025.
//

import SwiftUI
import PhotosUI

struct AddEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddEventViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
                VStack {
                    ScrollView {
                        AddEventDescriptionView(viewModel: viewModel)
                        AddEventDateView(viewModel: viewModel)
                        AddEventAdresseView(viewModel: viewModel)
                        AddEventPictureView(viewModel: viewModel)
                    }
                    
                    Button(action: {
                        Task {
                            let isOk = await viewModel.validate()
                            if isOk {
                                dismiss()
                            }
                        }
                    }) {
                        Text("Validate")
                            .foregroundColor(.white)
                            .font(.callout)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color("RedEventorias"))
                            .cornerRadius(4)
                    }
                }
                .padding(.horizontal)
                if viewModel.isValidating {
                    ProgressViewLoading()
                }
            
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
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
    
    
}

struct AddEventDescriptionView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    
    var body: some View {
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
        .accessibilityLabel("Event Title")
        
        
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
                        if (viewModel.event.category == category) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("FontTextFieldGray"))
                        }
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
                .background(Color("BackgroundGray"))
            }
            .padding(0)
        }
        .padding()
        .background(Color("BackgroundGray"))
        .cornerRadius(4)
        .preferredColorScheme(.dark)
        
        
        
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
        
    }
}

struct AddEventDateView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    @State private var showCalendarSheet: Bool = false
    
    var body: some View {
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
        
    }
    
    var mmddyyyyFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}

struct AddEventAdresseView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    
    var body: some View {
        
        // MARK: Zone Adresse
        VStack(alignment: .leading, spacing: 8) {
            Text("Address")
                .font(.caption)
                .foregroundColor(Color("FontGray"))
            TextField(
                "",
                text: $viewModel.event.address,
                prompt: Text("Enter full address")
                    .font(.callout)
                    .foregroundColor(Color("FontTextFieldGray"))
            )
            .font(.callout)
            .foregroundColor(Color("FontTextFieldGray"))
            
            .onChange(of: viewModel.event.address) {
                if (!viewModel.isAdressSelected) {
                    viewModel.searchAddress(viewModel.event.address)
                }
                viewModel.isAdressSelected = false
            }
            
            
            // MARK: List Adresse
            
            if !viewModel.results.isEmpty {
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
                        viewModel.adresseResult = address
                        viewModel.event.address = "\(address.title), \(address.subtitle)"
                        viewModel.results.removeAll()
                        viewModel.isAdressSelected = true
                    }
                    .listRowSeparatorTint(.gray)
                    .listRowBackground(Color("BackgroundGray"))
                }
                .listStyle(.plain)
                .frame(height: 200)
                .cornerRadius(8)
            }
            
            
            
        }
        .padding()
        .background(Color("BackgroundGray"))
        .cornerRadius(4)
        
        
    }
    
}

struct AddEventPictureView: View {
    
    @ObservedObject var viewModel: AddEventViewModel
    @State private var showCamera = false
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    
    var body: some View {
        // MARK: Photo
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        showCamera = true
                    }) {
                        Image(systemName: "camera")
                            .foregroundColor(.black)
                            .frame(width: 52, height: 52)
                            .background(Color(
                                .white))
                            .cornerRadius(16)
                    }
                }
                .sheet(isPresented: $showCamera) {
                    CameraPicker(image: $viewModel.capturedImage)
                }
                
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Image(systemName: "paperclip")
                        .foregroundColor(.white)
                        .frame(width: 52, height: 52)
                        .background(Color("RedEventorias"))
                        .cornerRadius(16)
                    
                }
                .onChange(of: selectedPhoto) {
                    Task {
                        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            viewModel.capturedImage = uiImage
                        }
                    }
                }
            }
            
            if let uiImage = viewModel.capturedImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                
            }
        }
    }
}
#Preview {
    AddEventView()
}
