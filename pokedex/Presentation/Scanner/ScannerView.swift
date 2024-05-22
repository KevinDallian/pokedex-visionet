//
//  ScannerView.swift
//  pokedex
//
//  Created by Kevin Dallian on 22/05/24.
//

import CodeScanner_Rownd
import SwiftUI

struct ScannerView: View {
    @State var showSheet = false
    @State var scannedText = ""
    var body: some View {
        VStack{
            Text(scannedText)
            Button {
                showSheet.toggle()
            } label: {
                Text("Start Scanning")
            }
        }
        .sheet(isPresented: $showSheet, content: {
            CodeScannerView(codeTypes: [.qr]) { result in
                switch result {
                case .success(let text):
                    scannedText = text.string
                    showSheet.toggle()
                case .failure(let error):
                    print("Error loading Code Scanner View : \(error.localizedDescription)")
                }
            }
        })
    }
}

#Preview {
    ScannerView()
}
