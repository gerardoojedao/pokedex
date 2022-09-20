//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 15-09-22.
//

import UIKit

let imageSize: CGFloat = 50

class PokemonCell: UITableViewCell {
    
    var imageUrl: String? {
        didSet {
            guard imageUrl != nil else {
                return
            }
            
            self.photoImageView.image = nil
            
            let url = URL(string: imageUrl!)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data!)
                }
            }
        }
    }

    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPokemonCell(with pokemon: Pokemon){
        nameLabel.text = pokemon.name?.capitalized
        
        let url = NSURL(string: pokemon.url!)
        let pokemonId = url?.lastPathComponent
        self.imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId!).png"
    }

}

extension PokemonCell {
    func setupUI(){
        
        addSubview(photoImageView)
        addSubview(nameLabel)
        
        photoImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 5).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true

        nameLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 15).isActive = true
        nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -15).isActive = true
    }
}
