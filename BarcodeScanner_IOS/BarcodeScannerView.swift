//
//  BarcodeScannerView.swift
//  BarcodeScanner_IOS
//
//  Created by Abhijit Maiti on 1/8/24.
//

import SwiftUI

struct BarcodeScannerView : View{
    var body: some View{
        NavigationView{
            VStack{
                
               ScannerView()
                .frame(maxWidth : .infinity , maxHeight: 300)
                .foregroundColor(.blue)
                .padding(.horizontal,30)
                Spacer().frame(maxWidth: .infinity, maxHeight: 70)
                VStack{
                    Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                        .font(.title)
                        
                    Text("Not Yet Scanned")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                }
                
            }
            .navigationTitle("Barcode Scanner")
            
        }
    }
}
struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
            .previewDevice("iPhone 11")
            .preferredColorScheme(.dark)
    }
}
