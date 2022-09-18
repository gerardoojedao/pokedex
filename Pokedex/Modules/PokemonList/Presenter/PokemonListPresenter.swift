//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 14-09-22.
//

import UIKit

class PokemonListPresenter: PokemonListPresenterProtocol {
    
    var view: PokemonListViewProtocol?
    var interactor: PokemonListInputInteractorProtocol?
    var wireframe: PokemonListWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.getPokemonList()
    }
    
    func showPokemonSelection(with pokemon: Pokemon, from view: UIViewController) {
        wireframe?.pushToPokemonDetail(with: pokemon, from: view)
    }
}

extension PokemonListPresenter: PokemonListOutputInteractorProtocol {
    func fetchPokemonListSuccess(pokemonList: [Pokemon]) {
        view?.showPokemons(with: pokemonList)
    }
    
    func fetchPokemonListError(error: String) {
        view?.showError(error: error)
    }
}
