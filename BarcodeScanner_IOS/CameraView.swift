//
//  CameraView.swift
//  BarcodeScanner_IOS
//
//  Created by Abhijit Maiti on 1/8/24.
//

import UIKit
import AVFoundation

enum CameraError :String {
    case invalidDeviceInput = "Somthing wrong with camera, Unable to scan barcode"
    case invalidScannedvalue = "The scanned value is invalid, This app can scan EAN-8 ad EAN-13"
}

protocol CameraViewDelegate :class   {
    func didFind(barcode: String)
    func didSurface(error : CameraError)
}

final class CameraView : UIViewController{
    
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    weak var cameraDelegate : CameraViewDelegate?
    
    init(cameraDelegate : CameraViewDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.cameraDelegate = cameraDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewlayer = previewLayer else {
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewlayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        let videoInput : AVCaptureDeviceInput
        do {
             try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch{
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(  videoInput){
            captureSession.addInput(videoInput)
        }else{
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput){
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [ .ean8,.ean13]
        }else{
            cameraDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
        
    }
    
    
}

extension CameraView : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            cameraDelegate?.didSurface(error: .invalidScannedvalue)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else{
            cameraDelegate?.didSurface(error: .invalidScannedvalue)
            return
        }
        guard let barcode = machineReadableObject.stringValue else{
            cameraDelegate?.didSurface(error: .invalidScannedvalue)
            return
        }
        
        
        cameraDelegate?.didFind(barcode: barcode)
    }
    
}
