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
    
    enum PokemonKeys: String, CodingKey
    {
        case id, name, url
    }
    
    init (from decoder: Decoder) throws {
        let container =  try decoder.container (keyedBy: PokemonKeys.self)
        id = try? container.decode (Int.self, forKey: .id)
        name = try? container.decode (String.self, forKey: .name)
        url = try? container.decode (String.self, forKey: .url)
    }
    
    func encode (to encoder: Encoder) throws {
        var container = encoder.container (keyedBy: PokemonKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (name, forKey: .name)
        try container.encode (url, forKey: .url)
    }
}
