//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 14-09-22.
//

import Foundation

class PokemonListPresenter: PokemonListPresenterProtocol {
    
    var view: PokemonListViewProtocol?
    var interactor: PokemonListInputInteractorProtocol?
    var wireframe: PokemonListWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.getPokemonList()
    }
}

extension PokemonListPresenter: PokemonListOutputInteractorProtocol {
    func pokemonListDidFetch() {
        
    }
}
