//
//  Alert.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//
import UIKit

class AlertMessage {
    static func show(with message: String, in view: UIViewController) {
        let alert = UIAlertController(title: "Ha ocurrido un error", message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(confirmAction)
        
        view.present(alert, animated: true, completion: nil)
    }
}
