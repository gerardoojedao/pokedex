//
//  PokemonClass.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import Foundation

struct Pokemon: Codable {
    let id: Int?
    let name: String?
    let url: String?
    let moves: [Move]?
    let abilities: [Ability]?
    let types: [Type]?
    let location_area_encounters: String?
    let species: NameAndUrl?
    var evolves_to: EvolvesTo?
    var encounters: [Encounters]?
    
    enum PokemonKeys: String, CodingKey
    {
        case id, name, url, moves, abilities, types, location_area_encounters, species
    }
    
    init (from decoder: Decoder) throws {
        let container =  try decoder.container (keyedBy: PokemonKeys.self)
        id = try? container.decode (Int.self, forKey: .id)
        name = try? container.decode (String.self, forKey: .name)
        url = try? container.decode (String.self, forKey: .url)
        moves = try? container.decode ([Move].self, forKey: .moves)
        abilities = try? container.decode ([Ability].self, forKey: .abilities)
        types = try? container.decode ([Type].self, forKey: .types)
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
}

struct Ability: Codable {
    let ability: NameAndUrl?
}

struct Move: Codable {
    let move: NameAndUrl?
}

struct Type: Codable {
    let type: NameAndUrl?
}

struct NameAndUrl: Codable {
    let name: String?
    let url: String?
}

struct Encounters: Codable {
    let location_area: NameAndUrl?
}

struct Evolution: Codable {
    let chain: EvolutionChain?
}

struct EvolutionChain: Codable {
    let evolves_to: [EvolvesTo]?
}

struct EvolvesTo: Codable {
    let species: NameAndUrl?
}
