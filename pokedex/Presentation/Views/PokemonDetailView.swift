//
//  PokemonDetailView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var vm : PokemonDetailViewModel
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: vm.pokemon.sprites.front_default))
            Text(capitalFirstLetter(text: vm.pokemon.name))
                .font(.title)
                .bold()
            List{
                Section("Types") {
                    ForEach(vm.pokemon.types, id: \.slot) { pokemonType in
                        Text(capitalFirstLetter(text: pokemonType.type.name))
                    }
                }
                Section("Abilities") {
                    ForEach(vm.pokemon.abilities, id: \.slot) { pokemonAbility in
                        Text(capitalFirstLetter(text: pokemonAbility.ability.name))
                    }
                }
                Section("Moves") {
                    ForEach(vm.pokemon.moves, id: \.hashValue) { pokemonMove in
                        Text(capitalFirstLetter(text: pokemonMove.move.name))
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    Task{
                        await vm.catchPokemon()
                    }
                } label: {
                    Text("Catch \(capitalFirstLetter(text: vm.pokemon.name))")
                }
            }
        }
        .alert(vm.isCaught ? "Congratulations!" : "You Failed", isPresented: $vm.showAlert) {
            if vm.isCaught {
                TextField("Enter a nickname", text: $vm.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Button("Save") {
                    
                }
            } else {
                Button("Dismiss") {
                    
                }
            }
        } message: {
            Text(vm.isCaught ? "You have caught \(capitalFirstLetter(text: vm.pokemon.name))!" : "You have failed catching \(capitalFirstLetter(text: vm.pokemon.name))")
        }

    }
}

//#Preview {
//    PokemonDetailView()
//}
