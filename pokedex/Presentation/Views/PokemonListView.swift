//
//  PokemonListView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var vm = PokemonListViewModel()
    var body: some View {
        NavigationStack{
            List(vm.pokemonList, id: \.id) { pokemon in
                NavigationLink(value: pokemon) {
                    ListComponent(pokemon: pokemon)
                }
            }
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                PokemonDetailView(vm: PokemonDetailViewModel(pokemon: pokemon))
            })
            .onAppear(perform: {
                vm.fetchPokemonList()
            })
            .navigationTitle("Pokemon List")
        }
    }
}

#Preview {
    PokemonListView()
}
