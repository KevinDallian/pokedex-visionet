//
//  PokemonListView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    var body: some View {
        NavigationStack{
            List(viewModel.pokemonList, id: \.id) { pokemon in
                NavigationLink(pokemon.name, value: pokemon)
            }
            .navigationDestination(for: Pokemon.self, destination: { pokemon in
                PokemonDetailView(pokemon: pokemon)
            })
            .onAppear(perform: {
                viewModel.fetchPokemonList()
            })
            .navigationTitle("Pokemon List")
        }
    }
}

#Preview {
    PokemonListView()
}
