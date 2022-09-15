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
        presenter?.pokemonListDidFetch()
    }

}
