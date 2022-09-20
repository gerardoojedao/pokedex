//
//  PokemonDetailsWireFrame.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import Foundation
import UIKit

class PokemonDetailsWireFrame: PokemonDetailsWireFrameProtocol {
    
    // MARK: Static methods
    static func createModule(with pokemonName: String) -> UIViewController {
        
        let viewController = PokemonDetailsTableViewController()
        
        let presenter: PokemonDetailsPresenterProtocol & PokemonDetailsOutputInteractorProtocol = PokemonDetailsPresenter()
        
        viewController.pokemonName = pokemonName
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.wireframe = PokemonDetailsWireFrame()
        viewController.presenter?.interactor = PokemonDetailsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToPokemonEvolution(with pokemon: Pokemon, from view: UIViewController) {
        let controller = PokemonDetailsWireFrame.createModule(with: (pokemon.evolves_to?.species?.name!)!)
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
