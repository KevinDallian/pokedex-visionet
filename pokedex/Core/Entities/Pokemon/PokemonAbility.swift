//
//  PokemonAbility.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct PokemonAbility : Hashable, Codable {
    let slot : Int
    let ability : Ability
}

struct Ability : Codable, Hashable {
    let name : String
    let url : String
}
