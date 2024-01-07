//
//  MainView.swift
//  BarcodeScanner_IOS
//
//  Created by Abhijit Maiti on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BarcodeScannerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11")
    }
}
