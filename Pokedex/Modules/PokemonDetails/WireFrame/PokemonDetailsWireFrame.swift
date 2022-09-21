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
    
    func pushToPokemonEvolution(with pokemon: PokemonObject, from view: UIViewController) {
        let controller = PokemonDetailsWireFrame.createModule(with: (pokemon.evolves?.name!)!)
        view.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pushToOptions(with options: [NameAndUrl], type: OptionType, from view: UIViewController) {
        let controller = PropertyListWireFrame.createModule(with: options, and: type)
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
