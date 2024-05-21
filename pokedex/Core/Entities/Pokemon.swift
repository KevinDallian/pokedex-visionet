//
//  Pokemon.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct Pokemon : Codable, Identifiable, Hashable {
    var id : Int
    var name : String
    var types : [PokemonType]
    var abilities : [PokemonAbility]
    var moves : [PokemonMove]
    var sprites : Sprites
    
    struct Sprites : Codable, Hashable {
        let front_default : String
        let back_default : String
        let front_shiny : String
        let back_shiny : String
    }
}
