//
//  DBManager.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 20-09-22.
//

import UIKit
import CoreData

class DBManager {

    static let shared = DBManager()
    
    public func addPokemon(pokemon: PokemonObject) {
        
        let dbManager = CoreDataService.shared
        let context = dbManager.persistentContainer.viewContext
        let entityDesc = NSEntityDescription.entity(forEntityName: "Pokemon", in: context)
        guard let entity = entityDesc else { return }
        let pokemonObj = Pokemon(entity: entity, insertInto: context)
        
        if let id = pokemon.id {
            pokemonObj.id = Int16(id)
        }
        
        pokemonObj.name = pokemon.name
        pokemonObj.url = pokemon.url
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Unable not save Employee \(error), \(error.userInfo)")
        }
    }
    
    public func fetchAllPokemons() -> [PokemonObject] {
        
        let dbManager = CoreDataService.shared
        let context = dbManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        var resultArray: [PokemonObject] = []
        
        do {
            let results = try context.fetch(fetchRequest) as! [Pokemon]
            
            for pokemon in results {
                
                let pokemonObj = PokemonObject()

                pokemonObj.id = Int(pokemon.id)
                pokemonObj.name = pokemon.name
                pokemonObj.url = pokemon.url
                
                resultArray.append(pokemonObj)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return resultArray
    }
    
    
    
    public func updatePokemon(pokemon: PokemonObject) -> Bool {
                
        guard let pokemonName = pokemon.name, let pokemonObj = self.getPokemonFromDB(name: pokemonName) else { return false }
        pokemonObj.name = pokemon.name
        pokemonObj.id = Int16(pokemon.id!)
        
        let dbManager = CoreDataService.shared
        let context = dbManager.persistentContainer.viewContext
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Unable not Update Employee \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    public func getPokemonFromDB(name: String) -> Pokemon? {
        
        let dbManager = CoreDataService.shared
        let context = dbManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        let predicate = NSPredicate(format:"name == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            guard let pokemon = (results as? [Pokemon])?.first else { return nil }
            return pokemon
        } catch let error as NSError {
            print("Unable to Fetch Employee \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    public func getPokemon(name: String) -> PokemonObject? {
        
        guard let pokemonObj = self.getPokemonFromDB(name: name) else { return nil }
        let pokemon = PokemonObject()
        
        pokemon.name = pokemonObj.name
        pokemon.url = pokemonObj.url
        pokemon.id = Int(pokemonObj.id)
        
        return pokemon
    }
}
