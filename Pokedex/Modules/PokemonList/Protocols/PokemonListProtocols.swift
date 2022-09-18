//
//  PokemonListProtocols.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 14-09-22.
//

import UIKit

protocol PokemonListViewProtocol {
    func showPokemons(with pokemons: [Pokemon])
    func showError(error: String)
}

protocol PokemonListPresenterProtocol {
    var interactor: PokemonListInputInteractorProtocol? {get set}
    var view: PokemonListViewProtocol? {get set}
    var wireframe: PokemonListWireFrameProtocol? {get set}
    
    func viewDidLoad()
    func showPokemonSelection(from view: UIViewController)
}

protocol PokemonListInputInteractorProtocol {
    var presenter: PokemonListOutputInteractorProtocol? {get set}
    
    func getPokemonList()
}

protocol PokemonListOutputInteractorProtocol {
    func fetchPokemonListSuccess(pokemonList: [Pokemon])
    func fetchPokemonListError(error: String)
}

protocol PokemonListWireFrameProtocol {
    static func createModule() -> UINavigationController
    func pushToPokemonDetail(from view: UIViewController)
}
