//
//  NFCReader.swift
//  pokedex
//
//  Created by Kevin Dallian on 23/05/24.
//

import CoreNFC
import Foundation

class NFCReader : NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    @Published var scannedText = ""
    var nfcSession : NFCNDEFReaderSession?
    
    func beginScanNFC(){
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error) {
        print("Error NFC Session \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for payload in messages[0].records {
            scannedText += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8) ?? "Format not supported"
        }
        print(scannedText)
    }
    
    
}
