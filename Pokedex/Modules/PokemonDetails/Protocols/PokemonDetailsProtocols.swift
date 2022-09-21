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
    func showPokemonEncounters(with encounters: [Encounters])
    func showPokemonEvolution(with evolution: Evolution)
    func showError(error: String)
}

protocol PokemonDetailsPresenterProtocol {
    var interactor: PokemonDetailsInputInteractorProtocol? {get set}
    var view: PokemonDetailsViewProtocol? {get set}
    var wireframe: PokemonDetailsWireFrameProtocol? {get set}
    
    func viewDidLoad()
    func showPokemonEvolutionSelection(with pokemon: Pokemon, from view: UIViewController)
    func showOptionSelection(with options: [NameAndUrl], type: OptionType, from view: UIViewController)

}

protocol PokemonDetailsInputInteractorProtocol {
    var presenter: PokemonDetailsOutputInteractorProtocol? {get set}
    
    func getPokemonDetails(with pokemonName: String)
    func getEncountersDetails(with id: String)
    func getEvolutionDetails(with id: String)
}

protocol PokemonDetailsOutputInteractorProtocol {
    func fetchPokemonDetailsSuccess(pokemonDetails: Pokemon)
    func fetchPokemonDetailsError(error: String)
    
    func fetchPokemonEncountersSuccess(encounters: [Encounters])
    func fetchPokemonEncountersDetailsError(error: String)
    
    func fetchPokemonEvolutionSuccess(evolution: Evolution)
    func fetchPokemonEvolutionError(error: String)
}

protocol PokemonDetailsWireFrameProtocol {
    static func createModule(with pokemonName: String) -> UIViewController
    func pushToPokemonEvolution(with pokemon: Pokemon, from view: UIViewController)
    func pushToOptions(with options: [NameAndUrl], type: OptionType, from view: UIViewController)

}
