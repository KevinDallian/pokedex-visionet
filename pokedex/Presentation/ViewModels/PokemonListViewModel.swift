//
//  PokemonListViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Combine
import Foundation

class PokemonListViewModel : ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    private var cancellable: AnyCancellable?
    let pokemonEndPoint = "https://pokeapi.co/api/v2/pokemon?limit=30&offset=0"

    func fetchPokemonList() {
        guard let url = URL(string: pokemonEndPoint) else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonListResponse.self, decoder: JSONDecoder())
            .flatMap { response in
                Publishers.MergeMany(response.results.map { self.fetchPokemonDetail(from: $0.url) })
                    .collect()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching Pokémon list: \(error)")
                }
            }, receiveValue: { [weak self] pokemonList in
                self?.pokemonList = pokemonList
            })
    }
    
    private func fetchPokemonDetail(from url: String) -> AnyPublisher<Pokemon, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
