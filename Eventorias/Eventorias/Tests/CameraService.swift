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
    
    override init() {
        super.init()
        addCameraInput()
        addVideoOutput()
        addPhotoOutput()
        startSession()
    }
    
    private func addPhotoOutput() {
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
    }
    
    private func addCameraInput() {
           if let device = AVCaptureDevice.default(for: .video) {
               do {
                   let cameraInput = try AVCaptureDeviceInput(device: device)
                   self.captureSession.addInput(cameraInput)
               } catch let error {
                   print("Error: \(error.localizedDescription)")
               }
           }
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
        guard let device = AVCaptureDevice.default(for: .video) else { return false }
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
    
    func takePhoto(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        self.captureCompletion = completion
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

}

extension CameraService {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            var ciiimage = CIImage(cvPixelBuffer: imageBuffer!)
            ciiimage = ciiimage.oriented(forExifOrientation: 6)
            if let cgImage = self.getCGImage(ciiimage) {
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
                  let uiImage = UIImage(data: imageData) else {
                captureCompletion?(nil)
                return
            }
            
            DispatchQueue.main.async {
                self.capturedImage = uiImage
                self.captureCompletion?(uiImage)
            }
        }
}
