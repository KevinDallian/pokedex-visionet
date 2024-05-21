//
//  MyPokemonView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct MyPokemonView: View {
    @StateObject var vm : MyPokemonViewModel
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        List(vm.pokemonList, id: \.nickname) { savedPokemon in
            NavigationLink {
                MyPokemonDetailView(vm: MyPokemonDetailViewModel(pokemon: savedPokemon, moc: moc, pvm: vm))
            } label: {
                ListComponent(title: savedPokemon.nickname, imageURL: savedPokemon.pokemon.sprites.firstAvailableImageURL)
            }
        }
        .onAppear(perform: {
            vm.fetchPokemonList()
        })
        .navigationTitle("My Pokemon List")
    }
}
