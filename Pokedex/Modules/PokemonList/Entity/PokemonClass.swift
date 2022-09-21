//
//  PokemonClass.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import Foundation

class PokemonObject: NSObject {

    public var id: Int?
    public var name: String?
    public var url: String?
    public var types: [NameAndUrl]?
    public var abilities: [NameAndUrl]?
    public var moves: [NameAndUrl]?
    public var encounters: [NameAndUrl]?
    public var evolves: NameAndUrl?
    public var location_area_encounters: String?
    
    override init() {
        
    }
    
}

struct PokemonClass: Codable {
    let id: Int16?
    var name: String?
    let url: String?
    let moves: [MoveClass]?
    let abilities: [AbilityClass]?
    let types: [TypeClass]?
    let location_area_encounters: String?
    let species: NameAndUrl?
    var evolves_to: EvolvesTo?
    var encounters: [EncountersClass]?
    
    enum PokemonKeys: String, CodingKey
    {
        case id, name, url, moves, abilities, types, location_area_encounters, species
    }
    
    init (from decoder: Decoder) throws {
        let container =  try decoder.container (keyedBy: PokemonKeys.self)
        id = try? container.decode (Int16.self, forKey: .id)
        name = try? container.decode (String.self, forKey: .name)
        url = try? container.decode (String.self, forKey: .url)
        moves = try? container.decode ([MoveClass].self, forKey: .moves)
        abilities = try? container.decode ([AbilityClass].self, forKey: .abilities)
        types = try? container.decode ([TypeClass].self, forKey: .types)
        location_area_encounters = try? container.decode (String.self, forKey: .location_area_encounters)
        species = try? container.decode (NameAndUrl.self, forKey: .species)
    }
    
    func encode (to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: PokemonKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (name, forKey: .name)
        try container.encode (url, forKey: .url)
        try container.encode (moves, forKey: .moves)
        try container.encode (abilities, forKey: .abilities)
        try container.encode (types, forKey: .types)
        try container.encode (location_area_encounters, forKey: .location_area_encounters)
        try container.encode (species, forKey: .species)
    }
    
    func getPokemonObject() -> PokemonObject {
        let pokemon = PokemonObject()
        
        if let id = self.id {
            pokemon.id = Int(id)
        }
        
        pokemon.name = self.name
        pokemon.url = self.url
        
        if let types = self.types {
            pokemon.types = types.map({(type) -> NameAndUrl in
                type.type!
            })
        }
        
        if let moves = self.moves {
            pokemon.moves = moves.map({(move) -> NameAndUrl in
                move.move!
            })
        }
        
        if let abilities = self.abilities {
            pokemon.abilities = abilities.map({(ability) -> NameAndUrl in
                ability.ability!
            })
        }
        
        if let location_area_encounters = self.location_area_encounters {
            pokemon.location_area_encounters = location_area_encounters
        }
        
        return pokemon
    }
}

struct AbilityClass: Codable {
    let ability: NameAndUrl?
}

struct MoveClass: Codable {
    let move: NameAndUrl?
}

struct TypeClass: Codable {
    let type: NameAndUrl?
}

struct NameAndUrl: Codable {
    let name: String?
    let url: String?
}

struct EncountersClass: Codable {
    let location_area: NameAndUrl?
}

struct EvolutionClass: Codable {
    let chain: EvolutionChain?
}
 
struct EvolutionChain: Codable {
    let evolves_to: [EvolvesTo]?
}

struct EvolvesTo: Codable {
    let species: NameAndUrl?
}
