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
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    
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
        self.tableView.register(PokemonCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.searchController = resultSearchController
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

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
    func showPokemons(with pokemons: [Pokemon]) {
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
