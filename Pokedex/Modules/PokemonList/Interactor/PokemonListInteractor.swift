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
        
        APIManager.shared.call(type: EndpointItem.pokemonList) { (result: Result<Response>) in
            switch result {
                case .Error(let errorDesciption):
                    self.presenter?.fetchPokemonListError(error: errorDesciption)
                    break
                case .Success(let responseResult):
                    self.presenter?.fetchPokemonListSuccess(pokemonList: responseResult.results)
                    break
            }
        }
    }
}

struct Response: Codable { // or Decodable
    let count: Int
    let results: [Pokemon]
}
