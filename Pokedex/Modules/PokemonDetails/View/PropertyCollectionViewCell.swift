//
//  PropertyCell.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import Foundation

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            button.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            button.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String) {
        button.setTitle(name, for: .normal)
    }
}
