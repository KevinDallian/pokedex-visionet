//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import CoreData
import Foundation
import SwiftUI

class PokemonDetailViewModel : ObservableObject {
    var moc : NSManagedObjectContext
    @Published var pokemon : Pokemon
    @Published var isCaught : Bool = false
    @Published var showAlert : Bool = false
    @Published var nickname : String = ""
    
    init(pokemon: Pokemon, moc: NSManagedObjectContext) {
        self.pokemon = pokemon
        self.moc = moc
    }
    
    func catchPokemon() {
        let randomNumber = Int.random(in: 0...10)
        let success = randomNumber > 5
        self.isCaught = success
        self.showAlert.toggle()
    }
    
    func savePokemon() async {
        let pokemon = SavedPokemon(id: "\(nickname)-0",nickname: nickname, renameCount: 0, pokemon: pokemon)
        CoreDataManager.shared.addPokemon(pokemon: pokemon, context: moc)
    }
}
