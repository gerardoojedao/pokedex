//
//  PropertyListTableViewController.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import UIKit

class PropertyListTableViewController: UITableViewController {

    var presenter:PropertyListPresenterProtocol?
    var options: [NameAndUrl] = []
    var optionType: OptionType?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = optionType?.rawValue.capitalized
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
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

        let option = options[indexPath.row]
        cell.textLabel?.text = option.name?.capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}

extension PropertyListTableViewController: PropertyListViewProtocol{
}
