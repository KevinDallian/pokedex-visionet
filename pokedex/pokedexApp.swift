//
//  pokedexApp.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import SwiftUI

@main
struct pokedexApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
        }
    }
}
