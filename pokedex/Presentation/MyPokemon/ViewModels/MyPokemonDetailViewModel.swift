//
//  MyPokemonDetailViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import CoreData
import Foundation
import SwiftUI

class MyPokemonDetailViewModel : ObservableObject {
    var moc : NSManagedObjectContext
    @ObservedObject var pvm : MyPokemonViewModel
    @Published var pokemon : SavedPokemon
    @Published var showAlert : Bool = false
    @Published var newNickname : String = ""
    @Published var isReleased : Bool = false
    @Published var showRelease : Bool = false
    
    init(pokemon: SavedPokemon, moc: NSManagedObjectContext, pvm: MyPokemonViewModel) {
        self.pokemon = pokemon
        self.newNickname = pokemon.nickname
        self.moc = moc
        self.pvm = pvm
    }
    
    func renamePokemon() async {
        let generatedId = fibonacci(of: pokemon.renameCount)
        let newPokemon = SavedPokemon(id: "\(newNickname)-\(generatedId)" ,nickname: newNickname, renameCount: pokemon.renameCount + 1, pokemon: pokemon.pokemon)
        let index = CoreDataManager.shared.pokemons.firstIndex { savedPokemon in
            savedPokemon.nameId! == pokemon.id
        }
        let viewModelIndex = pvm.pokemonList.firstIndex(of: pokemon)
        CoreDataManager.shared.editPokemon(index: index!, pokemon: newPokemon, context: moc)
        DispatchQueue.main.async{
            self.pokemon = newPokemon
            self.pvm.pokemonList[viewModelIndex!] = newPokemon
        }
    }
    
    func releasePokemon() {
        self.isReleased.toggle()
        self.showRelease.toggle()
    }
    
    func deletePokemon() {
        guard let index = CoreDataManager.shared.pokemons.firstIndex(where: { savedPokemon in
            savedPokemon.nameId == pokemon.id
        }) else {
            return
        }
        
        let viewModelIndex = pvm.pokemonList.firstIndex(of: pokemon)
        CoreDataManager.shared.deletePokemon(index: index, context: moc)
        self.pvm.pokemonList.remove(at: viewModelIndex!)
    }
}
