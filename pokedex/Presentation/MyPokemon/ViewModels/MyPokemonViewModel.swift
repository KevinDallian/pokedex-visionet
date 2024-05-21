//
//  MyPokemonViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

class MyPokemonViewModel : ObservableObject {
    @Published var pokemonList : [SavedPokemon] = []
    
    init() {
        
    }
    
    func fetchPokemonList(){
        self.pokemonList = CoreDataManager.shared.pokemons
    }
}
