//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 14-09-22.
//

import UIKit
import CoreData

let cellIdentifier = "pokemonCellIdentifier"

class PokemonListViewController: UITableViewController {

    var presenter:PokemonListPresenterProtocol?
    var pokemons = [PokemonObject]()
    var filteredPokemons = [PokemonObject]()
    
    lazy var resultSearchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.searchBar.sizeToFit()
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()

    }

    func setupUI(){
        title = "Pokédex"
        self.tableView.tableFooterView = UIView()
        self.tableView.register(PokemonCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.searchController = resultSearchController
    }

}

// MARK: - Table view data source

extension PokemonListViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredPokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PokemonCell
        let pokemon = filteredPokemons[indexPath.row]
        cell.setPokemonCell(with: pokemon)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let pokemon = filteredPokemons[indexPath.row]
        presenter?.showPokemonSelection(with: pokemon, from: self)
    }

}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count == 0 else {
            return
        }
        
        filteredPokemons = pokemons
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredPokemons = pokemons
        
        tableView.reloadData()
    }
}

extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count > 0 else { return }
        
        filteredPokemons = pokemons.filter({ pokemon in
            pokemon.name!.localizedStandardContains(text)
        })
        
        tableView.reloadData()
    }
}

extension PokemonListViewController: PokemonListViewProtocol {
    func showPokemons(with pokemons: [PokemonObject]) {
        self.pokemons = pokemons
        self.filteredPokemons = pokemons
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            AlertMessage.show(with: error, in: self)
        }
    }
}
