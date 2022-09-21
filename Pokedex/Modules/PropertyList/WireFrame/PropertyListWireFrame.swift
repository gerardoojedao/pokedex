//
//  PropertyListWireFrame.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import Foundation
import UIKit

class PropertyListWireFrame: PropertyListWireFrameProtocol {
    static func createModule(with options: [NameAndUrl], and type: OptionType) -> UIViewController {
        let viewController = PropertyListTableViewController()
        
        let presenter: PropertyListPresenterProtocol & PropertyListOutputInteractorProtocol = PropertyListPresenter()
        
        viewController.options = options
        viewController.optionType = type
        
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.wireframe = PropertyListWireFrame()
        viewController.presenter?.interactor = PropertyListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
