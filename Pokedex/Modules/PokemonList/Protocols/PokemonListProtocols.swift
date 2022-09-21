//
//  PokemonListProtocols.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 14-09-22.
//

import UIKit

protocol PokemonListViewProtocol {
    func showPokemons(with pokemons: [PokemonObject])
    func showError(error: String)
}

protocol PokemonListPresenterProtocol {
    var interactor: PokemonListInputInteractorProtocol? {get set}
    var view: PokemonListViewProtocol? {get set}
    var wireframe: PokemonListWireFrameProtocol? {get set}
    
    func viewDidLoad()
    func showPokemonSelection(with pokemon: PokemonObject, from view: UIViewController)
}

protocol PokemonListInputInteractorProtocol {
    var presenter: PokemonListOutputInteractorProtocol? {get set}
    
    func getPokemonList()
    func savePokemonList(pokemonList: [PokemonObject])
}

protocol PokemonListOutputInteractorProtocol {
    func fetchPokemonListSuccess(pokemonList: [PokemonObject])
    func fetchPokemonListError(error: String)
}

protocol PokemonListWireFrameProtocol {
    static func createModule() -> UINavigationController
    func pushToPokemonDetail(with pokemon: PokemonObject, from view: UIViewController)
}
