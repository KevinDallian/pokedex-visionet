//
//  SavedPokemon.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct SavedPokemon : Hashable, Codable {
    var nickname : String
    var renameCount : Int
    let pokemon : Pokemon
}
