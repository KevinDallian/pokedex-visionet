//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

class PokemonDetailViewModel : ObservableObject {
    @Published var pokemon : Pokemon
    @Published var isCaught : Bool = false
    @Published var showAlert : Bool = false
    @Published var username : String = ""
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func catchPokemon() async {
        do {
            let success = try await ExpressAPIManager.shared.catchPokemon()
            DispatchQueue.main.async{
                self.isCaught = success
                self.showAlert.toggle()
            }
        } catch let error {
            print("Error Catching pokemon : \(error)")
        }
    }
}
