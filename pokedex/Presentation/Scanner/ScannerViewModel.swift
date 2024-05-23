//
//  ScannerViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 23/05/24.
//

import CodeScanner_Rownd
import Foundation

class ScannerViewModel : ObservableObject {
    @Published var scannedText = "Scan a Pokemon URL to catch"
    @Published var showSheet = false
    @Published var loadingPokemon = false
    @Published var pokemon : Pokemon? = nil
    @Published var showError = false
    @Published var error : ScanningError? = nil
    
    func scanCompletion(result: Result<ScanResult, ScanError>) async {
        switch result {
        case .success(let success):
            DispatchQueue.main.async{
                self.scannedText = success.string
                self.showSheet.toggle()
            }
            do{
                try await fetchPokemon(urlString: success.string)
            } catch {
                print("Error fetching pokemon data: \(error.localizedDescription)")
            }
            
        case .failure(let error):
            print("Error scanning pokemon :\(error.localizedDescription)")
        }
    }
    
    func fetchPokemon(urlString: String) async throws{
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Cannot initialized URL : \(urlString)", code: 400)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            DispatchQueue.main.async{
                self.pokemon = pokemon
            }
        } catch {
            self.error = .urlNotFound
            DispatchQueue.main.async {
                self.showError.toggle()
            }
        }
        
    }
}
