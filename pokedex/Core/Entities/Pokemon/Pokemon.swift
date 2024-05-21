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
        
        var firstAvailableImageURL: URL? {
            let urls = [front_default, back_default, front_shiny, back_shiny]
            for urlString in urls {
                if let url = URL(string: urlString), !urlString.isEmpty {
                    return url
                }
            }
            return nil
        }
    }
}
