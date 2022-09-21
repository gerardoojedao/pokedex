//
//  PropertyListProtocols.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import UIKit

protocol PropertyListViewProtocol {
}

protocol PropertyListPresenterProtocol {
    var interactor: PropertyListInputInteractorProtocol? {get set}
    var view: PropertyListViewProtocol? {get set}
    var wireframe: PropertyListWireFrameProtocol? {get set}
    
    func viewDidLoad()

}

protocol PropertyListInputInteractorProtocol {
    var presenter: PropertyListOutputInteractorProtocol? {get set}
}

protocol PropertyListOutputInteractorProtocol {
    
}

protocol PropertyListWireFrameProtocol {
    static func createModule(with options: [NameAndUrl], and type: OptionType) -> UIViewController

}
