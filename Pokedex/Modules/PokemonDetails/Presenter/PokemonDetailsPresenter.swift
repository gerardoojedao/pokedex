//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//
import UIKit

class PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    
    var view: PokemonDetailsViewProtocol?
    var interactor: PokemonDetailsInputInteractorProtocol?
    var wireframe: PokemonDetailsWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.getPokemonDetails(with: (view?.pokemonName)!)
    }
}

extension PokemonDetailsPresenter: PokemonDetailsOutputInteractorProtocol {
    func fetchPokemonDetailsSuccess(pokemonDetails: Pokemon) {
        view?.showPokemonDetails(with: pokemonDetails)
    }
    
    func fetchPokemonDetailsError(error: String) {
        view?.showError(error: error)
    }
}

