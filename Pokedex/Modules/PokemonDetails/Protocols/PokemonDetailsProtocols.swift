//
//  PokemonDetailsProtocols.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import UIKit

protocol PokemonDetailsViewProtocol {
    var pokemonName: String? {get set}

    func showPokemonDetails(with pokemon: Pokemon)
    func showError(error: String)
}

protocol PokemonDetailsPresenterProtocol {
    var interactor: PokemonDetailsInputInteractorProtocol? {get set}
    var view: PokemonDetailsViewProtocol? {get set}
    var wireframe: PokemonDetailsWireFrameProtocol? {get set}
    
    func viewDidLoad()
}

protocol PokemonDetailsInputInteractorProtocol {
    var presenter: PokemonDetailsOutputInteractorProtocol? {get set}
    
    func getPokemonDetails(with pokemonName: String)
}

protocol PokemonDetailsOutputInteractorProtocol {
    func fetchPokemonDetailsSuccess(pokemonDetails: Pokemon)
    func fetchPokemonDetailsError(error: String)
}

protocol PokemonDetailsWireFrameProtocol {
    static func createModule(with pokemonName: String) -> UIViewController
}
