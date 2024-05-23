//
//  ScannerView.swift
//  pokedex
//
//  Created by Kevin Dallian on 22/05/24.
//

import CodeScanner_Rownd
import SwiftUI

struct ScannerView: View {
    @StateObject var vm = ScannerViewModel()
    @StateObject var nfcReader = NFCReader()
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{
            Text(vm.scannedText)
            Button {
                vm.showSheet.toggle()
            } label: {
                Text("Scan QR")
            }
            if let pokemon = vm.pokemon {
                PokemonDetailView(vm: PokemonDetailViewModel(pokemon: pokemon, moc: moc))
            }
            Button {
                nfcReader.beginScanNFC()
            } label: {
                Text("Scan NFC")
            }

        }
        .sheet(isPresented: $vm.showSheet, content: {
            CodeScannerView(codeTypes: [.qr]){ res in
                Task{
                    await vm.scanCompletion(result: res)
                }
            }
        })
        .alert(isPresented: $vm.showError, error: vm.error) {
            Button {
                
            } label: {
                Text("Dismiss")
            }

        }
    }
}

#Preview {
    ScannerView()
}
