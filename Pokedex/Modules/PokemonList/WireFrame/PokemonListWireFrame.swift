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
        
        let presenter: PokemonListPresenterProtocol & PokemonListOutputInteractorProtocol = PokemonListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.wireframe = PokemonListWireFrame()
        viewController.presenter?.interactor = PokemonListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToPokemonDetail() {
        
    }
}