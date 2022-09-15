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
    
    func showPokemonSelection(from view: UIViewController) {
        wireframe?.pushToPokemonDetail(from: view)
    }
}

extension PokemonListPresenter: PokemonListOutputInteractorProtocol {
    func pokemonListDidFetch() {
        
    }
}
