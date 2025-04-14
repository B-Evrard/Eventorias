//
//  MapView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 13/04/2025.
//


import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()

    private let address: AddressResult
    
    init(address: AddressResult) {
        self.address = address
    }
    
    var body: some View {
        
        
        Map {
            Marker("Empire state building", coordinate: viewModel.location)
                .tint(.orange)
            
//            Annotation("Diller Civic Center Playground", coordinate: viewModel.location) {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 5)
//                        .fill(Color.yellow)
//                    Text("🛝")
//                        .padding(5)
//                }
//            }
        }
        .mapStyle(.standard)
        .onAppear {
            self.viewModel.getPlace(from: address)
        }
    }
//        Map(
//            coordinateRegion: $viewModel.region,
//            annotationItems: viewModel.annotationItems,
//            annotationContent: { item in
//                MapMarker(coordinate: item.coordinate)
//            }
//        )
        
//        .edgesIgnoringSafeArea(.bottom)
//    }
}
