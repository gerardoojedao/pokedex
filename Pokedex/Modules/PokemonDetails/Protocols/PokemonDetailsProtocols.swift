//
//  PokemonDetailsProtocols.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import UIKit

protocol PokemonDetailsViewProtocol {
    var pokemonName: String? {get set}

    func showPokemonDetails(with pokemon: PokemonObject)
    func showPokemonEncounters(with encounters: [NameAndUrl])
    func showPokemonEvolution(with evolution: EvolutionClass)
    func showError(error: String)
}

protocol PokemonDetailsPresenterProtocol {
    var interactor: PokemonDetailsInputInteractorProtocol? {get set}
    var view: PokemonDetailsViewProtocol? {get set}
    var wireframe: PokemonDetailsWireFrameProtocol? {get set}
    
    func viewDidLoad()
    func showPokemonEvolutionSelection(with pokemon: PokemonObject, from view: UIViewController)
    func showOptionSelection(with options: [NameAndUrl], type: OptionType, from view: UIViewController)

}

protocol PokemonDetailsInputInteractorProtocol {
    var presenter: PokemonDetailsOutputInteractorProtocol? {get set}
    
    func getPokemonDetails(with pokemonName: String)
    func getEncountersDetails(with id: String)
    func getEvolutionDetails(with id: String)
}

protocol PokemonDetailsOutputInteractorProtocol {
    func fetchPokemonDetailsSuccess(pokemonDetails: PokemonObject)
    func fetchPokemonDetailsError(error: String)
    
    func fetchPokemonEncountersSuccess(encounters: [EncountersClass])
    func fetchPokemonEncountersDetailsError(error: String)
    
    func fetchPokemonEvolutionSuccess(evolution: EvolutionClass)
    func fetchPokemonEvolutionError(error: String)
}

protocol PokemonDetailsWireFrameProtocol {
    static func createModule(with pokemonName: String) -> UIViewController
    func pushToPokemonEvolution(with pokemon: PokemonObject, from view: UIViewController)
    func pushToOptions(with options: [NameAndUrl], type: OptionType, from view: UIViewController)

}
