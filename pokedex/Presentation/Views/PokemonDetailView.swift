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
            Text(pokemon.name)
        }
    }
}

//#Preview {
//    PokemonDetailView()
//}
