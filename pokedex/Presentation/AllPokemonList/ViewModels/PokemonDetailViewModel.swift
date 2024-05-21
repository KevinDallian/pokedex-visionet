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
    
    func catchPokemon() async {
        do {
            let success = try await ExpressAPIManager.shared.catchPokemon()
            DispatchQueue.main.async{
                self.isCaught = success
                self.showAlert.toggle()
            }
        } catch let error {
            print("Error Catching pokemon : \(error)")
        }
    }
    
    func savePokemon() async {
        let pokemon = SavedPokemon(nickname: nickname, renameCount: 0, pokemon: pokemon)
        CoreDataManager.shared.addPokemon(pokemon: pokemon, context: moc)
    }
}
