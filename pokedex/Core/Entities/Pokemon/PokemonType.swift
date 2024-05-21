//
//  Type.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct PokemonType : Codable, Hashable {
    let slot : Int
    let type : TypeDetails
}

struct TypeDetails : Codable, Hashable {
    let name : String
    let url : String
}
