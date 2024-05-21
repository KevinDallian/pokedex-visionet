//
//  MyPokemonDetailViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

class MyPokemonDetailViewModel : ObservableObject {
    @Published var pokemon : SavedPokemon
    @Published var showAlert : Bool = false
    @Published var newNickname : String = ""
    
    init(pokemon: SavedPokemon) {
        self.pokemon = pokemon
        self.newNickname = pokemon.nickname
    }
    
    func renamePokemon(){
        guard let index = CoreDataManager.shared.pokemons.firstIndex(of: pokemon) else {
            return
        }
        CoreDataManager.shared.pokemons[index].nickname = newNickname
        pokemon.nickname = newNickname
        showAlert.toggle()
    }
}
