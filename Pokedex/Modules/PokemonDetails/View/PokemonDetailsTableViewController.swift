//
//  PokemonDetailsTableViewController.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import UIKit

class PokemonDetailsTableViewController: UITableViewController {

    var presenter:PokemonDetailsPresenterProtocol?
    var pokemonName: String?
    var pokemonDetails: PokemonObject?
    var options: [OptionType] = []
    
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
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.masksToBounds = true
        headerView.backgroundColor = .clear
        return headerView
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        
        title = pokemonName?.capitalized
        edgesForExtendedLayout = []
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        headerView.addSubview(photoImageView)
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        
        photoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        photoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -30).isActive = true

        tableView.tableHeaderView?.layoutIfNeeded()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let option = options[indexPath.row]
        cell.textLabel?.text = option.rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let option = options[indexPath.row]
        if option == .evolution {
            presenter?.showPokemonEvolutionSelection(with: pokemonDetails!, from: self)
        }
        
        if option == .moves {
            presenter?.showOptionSelection(with: (pokemonDetails?.moves!)!, type: .moves, from: self)
        }
        
        if option == .abilities {
            presenter?.showOptionSelection(with: (pokemonDetails?.abilities!)!, type: .abilities, from: self)
        }
        
        if option == .types {
            presenter?.showOptionSelection(with: (pokemonDetails?.types!)!, type: .types, from: self)
        }
        
        if option == .encounters {
            presenter?.showOptionSelection(with: (pokemonDetails?.encounters!)!, type: .encounters, from: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension PokemonDetailsTableViewController: PokemonDetailsViewProtocol{
    
    func showError(error: String){
        DispatchQueue.main.async {
            AlertMessage.show(with: error, in: self)
        }
    }
    
    func showPokemonDetails(with pokemon: PokemonObject) {
        self.pokemonDetails = pokemon
        self.imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id!).png"
        
        if let _ = pokemon.types {
            self.options.append(.types)
        }
        
        if let _ = pokemon.abilities {
            self.options.append(.abilities)
        }
        
        if let _ = pokemon.moves {
            self.options.append(.moves)
        }
        
        self.reloadData()
    }
    
    func showPokemonEncounters(with encounters: [NameAndUrl]) {
        
        self.options.append(.encounters)
        self.pokemonDetails?.encounters = encounters
        self.reloadData()
    }
    
    func showPokemonEvolution(with evolution: EvolutionClass) {
        self.options.insert(.evolution, at: 0)
        self.reloadData()
    }
        
}

enum OptionType: String {
    case types = "Types"
    case abilities = "Abilities"
    case moves = "Moves"
    case encounters = "Encounters"
    case evolution = "Evolution"
}

struct Option {
    let type: OptionType?
}
