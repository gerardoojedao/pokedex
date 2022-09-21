//
//  PropertyListPresenter.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import Foundation

class PropertyListPresenter: PropertyListPresenterProtocol {
    
    var view: PropertyListViewProtocol?
    var interactor: PropertyListInputInteractorProtocol?
    var wireframe: PropertyListWireFrameProtocol?
    
    func viewDidLoad() {
    }

}

extension PropertyListPresenter: PropertyListOutputInteractorProtocol {
   
}

