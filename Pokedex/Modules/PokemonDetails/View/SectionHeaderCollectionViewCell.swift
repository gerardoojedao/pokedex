//
//  SectionHeaderCell.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import UIKit

class SectionHeaderCollectionViewCell: UICollectionReusableView {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
