//
//  CameraService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 11/05/2025.
//

import Foundation
import CoreGraphics
import AVFoundation
import CoreImage
import UIKit


class CameraService: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    
    @Published var cameraFrame: CGImage?
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let captureQueue = DispatchQueue.init(label: "Camera.service", qos: .userInitiated)
    private let photoOutput = AVCapturePhotoOutput()
    private var captureCompletion: ((UIImage?) -> Void)?
    @Published var capturedImage: UIImage?
    @Published var flashMode: AVCaptureDevice.FlashMode = .off
    @Published var currentCameraPosition: AVCaptureDevice.Position = .back
    @Published var isActive: Bool = false
    
    override init() {
        super.init()
        addCameraInput(position: currentCameraPosition)
        addVideoOutput()
        addPhotoOutput()
        startSession()
    }
    
    private func addPhotoOutput() {
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
    }
    
    private func addCameraInput(position: AVCaptureDevice.Position) {
        
        captureSession.inputs.forEach { captureSession.removeInput($0) }
        
        let deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInWideAngleCamera]
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: position
        )
        
        guard let device = discoverySession.devices.first else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch {
            print("Error: \(error.localizedDescription)")}
    }
    
    
    private func addVideoOutput() {
        self.videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        self.videoOutput.setSampleBufferDelegate(self, queue: captureQueue)
        self.captureSession.addOutput(videoOutput)
    }
    
    private func startSession() {
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let self = self else { return }
            self.captureSession.startRunning()
        }
    }
    
    func stopSession() {
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let self = self else { return }
            self.captureSession.stopRunning()
        }
    }
    
    func getCGImage(_ inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
    func isFlashAvailable() -> Bool {
        guard let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: currentCameraPosition
        ) else { return false }
        return device.hasFlash && device.isFlashAvailable
    }
    
    func toggleFlashMode() {
        switch flashMode {
        case .off:
            flashMode = .on
        case .on:
            flashMode = .auto
        case .auto:
            flashMode = .off
        @unknown default:
            flashMode = .off
        }
    }
    
    func switchCamera() {
        captureQueue.async { [weak self] in
            guard let self else { return }
            
            let newPosition: AVCaptureDevice.Position = (currentCameraPosition == .back) ? .front : .back
            DispatchQueue.main.async {
                        self.currentCameraPosition = newPosition
                    }
            self.captureSession.beginConfiguration()
            self.addCameraInput(position: newPosition)
            
            if let connection = self.videoOutput.connection(with: .video) {
                connection.videoRotationAngle = 0
            }
            
            self.captureSession.commitConfiguration()
        }
    }
    
    func takePhoto(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        self.captureCompletion = completion
        if let connection = photoOutput.connection(with: .video) {
            if currentCameraPosition == .front {
                connection.isVideoMirrored = false
            }
        }
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
}

extension CameraService {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            var ciImage = CIImage(cvPixelBuffer: imageBuffer!)
            ciImage = ciImage.oriented(forExifOrientation: 6)
            if self.currentCameraPosition == .front {
                ciImage = ciImage.transformed(by: CGAffineTransform(scaleX: -1, y: 1))
            }
            if let cgImage = self.getCGImage(ciImage) {
                self.isActive = true
                self.cameraFrame = cgImage
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let error = error {
            print("Erreur : \(error.localizedDescription)")
            captureCompletion?(nil)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              var uiImage = UIImage(data: imageData) else {
            captureCompletion?(nil)
            return
        }
        
        if currentCameraPosition == .front {
            if let cgImage = uiImage.cgImage {
                uiImage = UIImage(cgImage: cgImage, scale: uiImage.scale, orientation: .leftMirrored)
            }
        }
        
        DispatchQueue.main.async {
            self.capturedImage = uiImage
            self.captureCompletion?(uiImage)
        }
    }
}
