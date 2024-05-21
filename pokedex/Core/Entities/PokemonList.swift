//
//  PokemonList.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct PokemonListResponse : Codable {
    let results: [PokemonSummary]
        
    struct PokemonSummary: Codable {
        let name: String
        let url: String
    }
}
