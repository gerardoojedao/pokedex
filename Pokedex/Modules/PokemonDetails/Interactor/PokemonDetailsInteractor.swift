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
        APIManager.shared.call(type: EndpointItem.pokemonDetail(name: pokemonName)) { (result: Result<Pokemon>) in
            switch result {
                case .Error(let errorDesciption):
                    self.presenter?.fetchPokemonDetailsError(error: errorDesciption)
                    break
                case .Success(let responseResult):
                    self.presenter?.fetchPokemonDetailsSuccess(pokemonDetails: responseResult)
                    break
            }
        }
    }
    
    func getEncountersDetails(with id: String) {
        APIManager.shared.call(type: EndpointItem.encounters(id: id)) { (result: Result<[Encounters]>) in
            
            print(result)
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
        APIManager.shared.call(type: EndpointItem.evolution(id: id)) { (result: Result<Evolution>) in
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
