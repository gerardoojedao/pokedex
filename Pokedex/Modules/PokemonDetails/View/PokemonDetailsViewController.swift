//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    var presenter:PokemonDetailsPresenterProtocol?
    var pokemonName: String?
    
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
        imageView.backgroundColor = .red
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        title = pokemonName
        edgesForExtendedLayout = []

        self.navigationItem.largeTitleDisplayMode = .never

        self.view.backgroundColor = .white
        self.view.addSubview(photoImageView)
        self.view.addSubview(nameLabel)
        
        photoImageView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 20).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 25).isActive = true

        nameLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(lessThanOrEqualTo: self.view.rightAnchor, constant: -15).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonDetailsViewController: PokemonDetailsViewProtocol{
    func showError(error: String){
        DispatchQueue.main.async {
            AlertMessage.show(with: error, in: self)
        }
    }
    
    func showPokemonDetails(with pokemon: Pokemon) {
        print(pokemon)
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id!).png"
        }
    }
        
}
