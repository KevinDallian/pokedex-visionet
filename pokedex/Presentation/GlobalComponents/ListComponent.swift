//
//  ListComponent.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

struct ListComponent: View {
    let pokemon : Pokemon
    var body: some View {
        HStack{
            AsyncImage(url: pokemon.sprites.firstAvailableImageURL) { image in
                image.image?.resizable()
            }
            .frame(width: 80, height: 80)
            Text(capitalFirstLetter(text: pokemon.name))
        }
    }
}

//#Preview {
//    ListComponent()
//}
