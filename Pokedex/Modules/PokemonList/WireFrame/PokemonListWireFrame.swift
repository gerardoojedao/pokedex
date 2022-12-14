//
//  PokemonListWireFrame.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 14-09-22.
//

import Foundation
import UIKit

class PokemonListWireFrame: PokemonListWireFrameProtocol {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        let viewController = PokemonListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        let presenter: PokemonListPresenterProtocol & PokemonListOutputInteractorProtocol = PokemonListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.wireframe = PokemonListWireFrame()
        viewController.presenter?.interactor = PokemonListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToPokemonDetail(with pokemon: PokemonObject, from view: UIViewController) {
        let controller = PokemonDetailsWireFrame.createModule(with: pokemon.name!)
        view.navigationController?.pushViewController(controller, animated: true)
    }
}
