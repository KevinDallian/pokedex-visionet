//
//  CoreDataManager.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

class CoreDataManager {
    var pokemons : [SavedPokemon] = []
    static let shared = CoreDataManager()
    
    private init(){}
    
    
}
