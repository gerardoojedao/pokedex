//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 15-09-22.
//

import Foundation

class PokemonListInteractor: PokemonListInputInteractorProtocol {
    var presenter: PokemonListOutputInteractorProtocol?

    func getPokemonList() {
        
        APIManager.shared.call(type: EndpointItem.pokemonList, params: nil) { (result: Response?, error: String?) in
            self.presenter?.pokemonListDidFetch(pokemonList: result!.results)
        }
    }
}

struct Response: Codable { // or Decodable
    let count: Int
    let results: [Pokemon]
}
