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
        do {
            let data = try await ExpressAPIManager.shared.renamePokemon(name: newNickname, renameCount: pokemon.renameCount)
            let newPokemon = SavedPokemon(id: data.0 ,nickname: newNickname, renameCount: data.1, pokemon: pokemon.pokemon)
            let index = CoreDataManager.shared.pokemons.firstIndex { savedPokemon in
                savedPokemon.nickname! == pokemon.nickname
            }
            CoreDataManager.shared.editPokemon(index: index!, pokemon: newPokemon, context: moc)
            DispatchQueue.main.async{
                self.pokemon = newPokemon
                self.pvm.pokemonList[index!] = newPokemon
            }
        } catch let error {
            print("Error renaming Pokemon : \(error)")
        }
    }
    
    func releasePokemon() async {
        do{
            let isPrime = try await ExpressAPIManager.shared.releasePokemon()
            DispatchQueue.main.async{
                self.isReleased = isPrime
                self.showRelease.toggle()
            }
        } catch let error {
            print("Error releasing pokemon : \(error)")
        }
    }
    
    func deletePokemon() {
        guard let index = CoreDataManager.shared.pokemons.firstIndex(where: { savedPokemon in
            savedPokemon.nameId == pokemon.id
        }) else {
            return
        }
        CoreDataManager.shared.pokemons.remove(at: index)
        self.pvm.pokemonList.remove(at: index)
    }
}
