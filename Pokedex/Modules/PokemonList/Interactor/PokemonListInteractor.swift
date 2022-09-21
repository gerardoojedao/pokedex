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
        
        let localResults = DBManager.shared.fetchAllPokemons()
        guard localResults.count == 0 else {
            print(localResults)
            self.presenter?.fetchPokemonListSuccess(pokemonList: localResults)
            return
        }
    
        
        APIManager.shared.call(type: EndpointItem.pokemonList) { (result: Result<Response>) in
            switch result {
                case .Error(let errorDesciption):
                    self.presenter?.fetchPokemonListError(error: errorDesciption)
                    break
                case .Success(let responseResult):
                    
                    let array = responseResult.results.map({(pokemon) -> PokemonObject in
                        pokemon.getPokemonObject()
                    })
                    
                    self.savePokemonList(pokemonList: array)
                    self.presenter?.fetchPokemonListSuccess(pokemonList: array)
                    break
            }
        }
    }
    
    func savePokemonList(pokemonList: [PokemonObject]){
        DispatchQueue.main.async {
            for pokemon in pokemonList {
                DBManager.shared.addPokemon(pokemon: pokemon)
            }
        }
    }
}

struct Response: Codable { // or Decodable
    let count: Int
    let results: [PokemonClass]
}
