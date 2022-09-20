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
    
    enum PokemonKeys: String, CodingKey
    {
        case id, name, url, moves, abilities, types, location_area_encounters
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
