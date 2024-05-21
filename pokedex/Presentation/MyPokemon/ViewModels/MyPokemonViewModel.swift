//
//  MyPokemonViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//
import CoreData
import Foundation

class MyPokemonViewModel : ObservableObject {
    @Published var pokemonList : [SavedPokemon] = []
    var moc : NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        fetchPokemonList()
    }
    
    func fetchPokemonList() {
        let pokemonEntities = CoreDataManager.shared.pokemons
        for savedPokemon in pokemonEntities {
            Task {
                await fetchPokemonDetails(pokemonEntity: savedPokemon)
            }
        }
    }
    
    func fetchPokemonDetails(pokemonEntity : SavedPokemonEntity) async {
        guard let url = URL(string: pokemonEntity.pokemonUrl!) else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            let savedPokemon = SavedPokemon(nickname: pokemonEntity.nickname!, renameCount: Int(pokemonEntity.renameCount), pokemon: pokemon)
            DispatchQueue.main.async {
                self.pokemonList.append(savedPokemon)
            }
        } catch {
            print("Error fetching pokemon detail: \(error)")
        }
    }
}
