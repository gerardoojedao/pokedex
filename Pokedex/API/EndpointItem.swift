//
//  EndpointItem.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 15-09-22.
//
import Foundation

enum EndpointItem {
    case pokemonList
    case anotherEnpoint
}

enum HttpMethod:String{
    case get = "get"
    case post = "post"
}

protocol EndPointType {
        
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var headers: [String: Any]? { get }
    var url: URL { get }
    var version: String { get }
}

extension EndpointItem: EndPointType {
        
    var baseURL: String {
        return "https://pokeapi.co/api/"
    }
    
    var version: String {
        return "v2"
    }
        
    var path: String {
        switch self {
            
        case .pokemonList:
            return "/pokemon?limit=150&offset=0"
        default:
            return "/"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        default:
            return .get
        }
    }
        
    var headers: [String: Any]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
            ]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.version + self.path)!
        }
    }
}
