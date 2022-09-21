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
    
    func showPokemonEvolutionSelection(with pokemon: PokemonObject, from view: UIViewController) {
        wireframe?.pushToPokemonEvolution(with: pokemon, from: view)
    }
    
    func showOptionSelection(with options: [NameAndUrl], type: OptionType, from view: UIViewController) {
        wireframe?.pushToOptions(with: options, type: type, from: view)
    }
}

extension PokemonDetailsPresenter: PokemonDetailsOutputInteractorProtocol {
    func fetchPokemonDetailsSuccess(pokemonDetails: PokemonObject) {
                
        view?.showPokemonDetails(with: pokemonDetails)
        
        if pokemonDetails.location_area_encounters != nil {
            interactor?.getEncountersDetails(with: String(pokemonDetails.id!))
        }
        
        if let pokemonId = pokemonDetails.id {
            interactor?.getEvolutionDetails(with: String(pokemonId))
        }
        
    }
    
    func fetchPokemonDetailsError(error: String) {
        view?.showError(error: error)
    }
    
    func fetchPokemonEncountersSuccess(encounters: [EncountersClass]) {
        guard encounters.count > 0 else {
            return
        }
        
        let array = encounters.map({(encounter) -> NameAndUrl in
            (encounter.location_area)!
        })
        
        view?.showPokemonEncounters(with: array)
    }
    
    func fetchPokemonEncountersDetailsError(error: String) {
        view?.showError(error: error)
    }
    
    func fetchPokemonEvolutionSuccess(evolution: EvolutionClass) {
        guard let evolves_to = evolution.chain?.evolves_to else {
            return
        }
        
        guard evolves_to.count > 0 else {
            return
        }
        
        view?.showPokemonEvolution(with: evolution)
    }
    
    func fetchPokemonEvolutionError(error: String) {
        view?.showError(error: error)

    }
}

