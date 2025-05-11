//
//  CameraFeedView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/05/2025.
//

import SwiftUI
struct CameraFeedView: View {
    @StateObject var cameraService = CameraService()
    var body: some View {
        VStack {
            if let frame = cameraService.cameraFrame {
                Image(decorative: frame, scale: 1, orientation: .right)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                
            } else {
                Text("Please wait....")
            }
        }.onDisappear(perform: {
            cameraService.stopSession()
        })
    }
}

#Preview {
    CameraFeedView()
}
