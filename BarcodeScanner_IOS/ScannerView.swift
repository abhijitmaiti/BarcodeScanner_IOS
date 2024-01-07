//
//  ScannerView.swift
//  BarcodeScanner_IOS
//
//  Created by Abhijit Maiti on 1/8/24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
   
    func makeUIViewController(context: Context) -> CameraView {
        CameraView(cameraDelegate: context.coordinator)
        
    }
    
    func updateUIViewController(_ uiViewController: CameraView, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, CameraViewDelegate{
        func didFind(barcode: String) {
            print(barcode)
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
        
        
    }
    
    

}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
