//
//  PokemonListView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var vm = PokemonListViewModel()
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationStack{
            List(vm.pokemonList, id: \.id) { pokemon in
                NavigationLink(value: pokemon) {
                    ListComponent(title: pokemon.name, imageURL: pokemon.sprites.firstAvailableImageURL)
                }
            }
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                PokemonDetailView(vm: PokemonDetailViewModel(pokemon: pokemon, moc: moc))
            })
            .onAppear(perform: {
                vm.fetchPokemonList()
            })
            .navigationTitle("Pokemon List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink("My Pokemon") {
                        MyPokemonView(vm: MyPokemonViewModel(moc: moc))
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonListView()
}
