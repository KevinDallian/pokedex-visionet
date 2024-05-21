//
//  CoreDataManager.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import CoreData
import Foundation

class CoreDataManager : ObservableObject {
    var pokemons : [SavedPokemonEntity] = []
    let container = NSPersistentContainer(name: "PersistentStorage")
    static let shared = CoreDataManager()
    
    private init(){
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error loading persistent store : \(error)")
            }
            self.fetchPokemons(context: self.container.viewContext)
        }
    }
    
    func save(context : NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error {
            print("Error saving context :\(error)")
        }
    }
    
    func fetchPokemons(context: NSManagedObjectContext){
        let request = NSFetchRequest<SavedPokemonEntity>(entityName: "SavedPokemonEntity")
        
        do{
            pokemons = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching saved pokemons: \(error)")
        }
    }
    
    func addPokemon(pokemon: SavedPokemon, context : NSManagedObjectContext) {
        let savedPokemon = SavedPokemonEntity(context: context)
        savedPokemon.nameId = pokemon.id
        savedPokemon.nickname = pokemon.nickname
        savedPokemon.renameCount = Int32(pokemon.renameCount)
        savedPokemon.pokemonUrl = "https://pokeapi.co/api/v2/pokemon/\(pokemon.pokemon.name)"
        savedPokemon.imageUrl = "\(String(describing: pokemon.pokemon.sprites.firstAvailableImageURL))"
        save(context: context)
    }
    
    func editPokemon(index: Int, pokemon: SavedPokemon, context : NSManagedObjectContext) {
        var newPokemon = pokemons[index]
        newPokemon.nickname = pokemon.nickname
        save(context: context)
    }
    
    func deletePokemon(index: Int, context: NSManagedObjectContext){
        let pokemon = pokemons[index]
        print(pokemon)
        container.viewContext.delete(pokemon)
        save(context: context)
    }
    
}
