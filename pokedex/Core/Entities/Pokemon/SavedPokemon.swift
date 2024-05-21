//
//  SavedPokemon.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct SavedPokemon : Hashable, Codable {
    var id : String
    var nickname : String
    var renameCount : Int
    let pokemon : Pokemon
    
    init(id: String, nickname: String, renameCount: Int, pokemon: Pokemon) {
        self.id = id
        self.nickname = nickname
        self.renameCount = renameCount
        self.pokemon = pokemon
    }
}
