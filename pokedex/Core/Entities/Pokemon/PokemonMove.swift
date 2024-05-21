//
//  PokemonMove.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct PokemonMove: Codable, Hashable {
    let move : MoveDetail
}

struct MoveDetail: Codable, Hashable {
    let name : String
    let url : String
}
