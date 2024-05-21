//
//  PokemonDetailView.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @State var pokemon : Pokemon
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: pokemon.sprites.front_default))
            Text(capitalFirstLetter(text: pokemon.name))
                .font(.title)
                .bold()
            List{
                Section("Types") {
                    ForEach(pokemon.types, id: \.slot) { pokemonType in
                        Text(capitalFirstLetter(text: pokemonType.type.name))
                    }
                }
                Section("Abilities") {
                    
                    ForEach(pokemon.abilities, id: \.slot) { pokemonAbility in
                        Text(capitalFirstLetter(text: pokemonAbility.ability.name))
                    }
                }
                Section("Moves") {
                    ForEach(pokemon.moves, id: \.hashValue) { pokemonMove in
                        Text(capitalFirstLetter(text: pokemonMove.move.name))
                    }
                }
            }
        }
       
    }
}

//#Preview {
//    PokemonDetailView()
//}
