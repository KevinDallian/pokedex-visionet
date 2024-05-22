//
//  MyPokemonDetailView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct MyPokemonDetailView: View {
    @StateObject var vm : MyPokemonDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: vm.pokemon.pokemon.sprites.front_default))
            HStack{
                Text(capitalFirstLetter(text: vm.pokemon.nickname))
                    .font(.title)
                    .bold()
                Button {
                    vm.showAlert.toggle()
                } label: {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            List{
                Section("Name ID") {
                    Text(vm.pokemon.id)
                }
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
                    vm.releasePokemon()
                } label: {
                    Text("Release")
                        .foregroundStyle(.red)
                }

            }
        }
        .alert("Rename", isPresented: $vm.showAlert) {
            TextField("\(vm.pokemon.nickname)", text: $vm.newNickname)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Button("Save") {
                Task{
                    await vm.renamePokemon()
                }
            }
        } message: {
            Text("Enter a new name for \(vm.pokemon.nickname)")
        }
        .alert(vm.isReleased ? "Released \(vm.pokemon.nickname)" : "Release Failed", isPresented: $vm.showRelease) {
            Button("Dismiss") {
                if vm.isReleased {
                    dismiss()
                    vm.deletePokemon()
                }
            }
        } message: {
            Text(vm.isReleased ? "\(vm.pokemon.nickname) has been released" : "Failed to release \(vm.pokemon.nickname)")
        }
    }
}
