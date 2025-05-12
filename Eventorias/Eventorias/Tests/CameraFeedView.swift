//
//  CameraFeedView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/05/2025.
//

import SwiftUI
import AVFoundation
import SwiftUI

struct CameraFeedView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var cameraService = CameraService()
    @State private var capturedImage: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .ignoresSafeArea()
                } else if let frame = cameraService.cameraFrame {
                    Image(decorative: frame, scale: 1)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .ignoresSafeArea()
                } else {
                    Color.white.ignoresSafeArea()
                }
                
                
                // Bouton flash en haut à droite
                VStack {
                    HStack {
                        Button(action: {
                            cameraService.toggleFlashMode()
                        }) {
                            Image(systemName: iconName(for: cameraService.flashMode))
                                .font(.title)
                                .foregroundColor(color(for: cameraService.flashMode))
                                .padding()
                                .background(Circle().fill(Color.black.opacity(0.7)))
                        }
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Boutons d'action en bas
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 62))
                                .foregroundColor(.black)
                                .shadow(radius: 4)
                                .padding()
                        }
                        Spacer()
                        Button {
                            cameraService.takePhoto { image in
                                if let image = image {
                                    capturedImage = image
                                }
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 3)
                                    .frame(width: 62, height: 62)
                                Circle()
                                    .fill(.black)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        Spacer()
                        Button {
                            // Action pour switcher la caméra
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 30)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    // Utilitaires pour l'icône du flash
    func iconName(for mode: AVCaptureDevice.FlashMode) -> String {
        switch mode {
        case .off: return "bolt.slash.fill"
        case .on: return "bolt.fill"
        case .auto: return "bolt.badge.a.fill"
        @unknown default: return "bolt.slash.fill"
        }
    }
    func color(for mode: AVCaptureDevice.FlashMode) -> Color {
        switch mode {
        case .off: return .gray
        case .on: return .yellow
        case .auto: return .blue
        @unknown default: return .gray
        }
    }
}


#Preview {
    CameraFeedView()
}
