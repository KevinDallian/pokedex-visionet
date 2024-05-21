//
//  MyPokemonDetailView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct MyPokemonDetailView: View {
    @StateObject var vm : MyPokemonDetailViewModel
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: vm.pokemon.pokemon.sprites.front_default))
            Text(capitalFirstLetter(text: vm.pokemon.nickname))
                .font(.title)
                .bold()
            List{
                Section("Types") {
                    ForEach(vm.pokemon.pokemon.types, id: \.slot) { pokemonType in
                        Text(capitalFirstLetter(text: pokemonType.type.name))
                    }
                }
                Section("Abilities") {
                    ForEach(vm.pokemon.pokemon.abilities, id: \.slot) { pokemonAbility in
                        Text(capitalFirstLetter(text: pokemonAbility.ability.name))
                    }
                }
                Section("Moves") {
                    ForEach(vm.pokemon.pokemon.moves, id: \.hashValue) { pokemonMove in
                        Text(capitalFirstLetter(text: pokemonMove.move.name))
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    vm.showAlert.toggle()
                } label: {
                    Text("Rename")
                }

            }
        }
        .alert("Rename", isPresented: $vm.showAlert) {
            TextField("\(vm.pokemon.nickname)", text: $vm.newNickname)
            Button("Save") {
                vm.renamePokemon()
            }
        } message: {
            Text("Enter a new name for \(vm.pokemon.nickname)")
        }

    }
}
