//
//  PokemonDetailsInteractor.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import Foundation

class PokemonDetailsInteractor: PokemonDetailsInputInteractorProtocol {
    var presenter: PokemonDetailsOutputInteractorProtocol?
    
    func getPokemonDetails(with pokemonName: String) {
        
        let localResult = DBManager.shared.getPokemon(name: pokemonName)
        guard (localResult != nil && localResult!.types == nil && localResult!.moves == nil && localResult!.abilities == nil) else {
            self.presenter?.fetchPokemonDetailsSuccess(pokemonDetails: localResult!)
            return
        }
        
        APIManager.shared.call(type: EndpointItem.pokemonDetail(name: pokemonName)) { (result: Result<PokemonClass>) in
            switch result {
                case .Error(let errorDesciption):
                    self.presenter?.fetchPokemonDetailsError(error: errorDesciption)
                    break
                case .Success(let responseResult):
                    let pokemonObject = responseResult.getPokemonObject()
                    let _ = DBManager.shared.updatePokemon(pokemon: pokemonObject)
                    self.presenter?.fetchPokemonDetailsSuccess(pokemonDetails: pokemonObject)
                    break
            }
        }
    }
    
    func getEncountersDetails(with id: String) {
        APIManager.shared.call(type: EndpointItem.encounters(id: id)) { (result: Result<[EncountersClass]>) in
            switch result {
                case .Error(let errorDesciption):
                    self.presenter?.fetchPokemonEncountersDetailsError(error: errorDesciption)
                    break
                case .Success(let responseResult):
                    self.presenter?.fetchPokemonEncountersSuccess(encounters: responseResult)
                    break
            }
        }
    }
    
    func getEvolutionDetails(with id: String) {
        APIManager.shared.call(type: EndpointItem.evolution(id: id)) { (result: Result<EvolutionClass>) in
            switch result {
                case .Error(let errorDesciption):
                    self.presenter?.fetchPokemonEvolutionError(error: errorDesciption)
                    break
                case .Success(let responseResult):
                    self.presenter?.fetchPokemonEvolutionSuccess(evolution: responseResult)
                    break
            }
        }
    }
}
