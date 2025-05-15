//
//  CameraFeedView.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/05/2025.
//

import SwiftUI
import AVFoundation

struct CameraFeedView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var cameraService = CameraService()
    @State private var capturedImage: UIImage?
    
    @State private var didValidate = false
    var onDismiss: (UIImage?) -> Void
    
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
                    Color.black.ignoresSafeArea()
                    Text("Please wait !!")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                
                if (cameraService.isActive) {
                    VStack {
                        HStack {
                            HStack {
                                Button(action: {
                                    cameraService.toggleFlashMode()
                                }) {
                                    Image(systemName: iconName(for: cameraService.flashMode))
                                        .font(.title)
                                        .foregroundColor(color(for: cameraService.flashMode))
                                        .padding()
                                }
                            }
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .shadow(radius: 4)
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                        
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                if capturedImage != nil {
                                    capturedImage = nil
                                } else {
                                    dismiss()
                                }
                                
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
                            if capturedImage != nil {
                                Button(action: {
                                    didValidate = true
                                    onDismiss(capturedImage)
                                    dismiss()
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 62))
                                        .foregroundColor(.black)
                                        .shadow(radius: 4)
                                        .padding()
                                }
                            } else {
                                Button {
                                    cameraService.switchCamera()
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Spacer()
                        }
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .shadow(radius: 4)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                }
            }
            .onDisappear {
                cameraService.stopSession()
                if !didValidate {
                    onDismiss(nil)
                }
            }
        }
    }
    
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
    CameraFeedView { image in
        
    }
}
