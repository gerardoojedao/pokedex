//
//  APIManager.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 15-09-22.
//
import UIKit

class APIManager {
    static let shared: APIManager = { 
        let manager = APIManager()
        return manager
    }()
}

extension APIManager {
    
    func call<T>(type: EndPointType, params: [String: Any]? = nil, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
        
        var request = URLRequest(url: type.url)
        
        for (key, value) in type.headers ?? [:] {
            print(key, value)
            request.addValue(value as? String ?? "", forHTTPHeaderField: key)
        }
       
        request.httpMethod = type.httpMethod.rawValue
        
        if (params != nil) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            if (data != nil){
                let jsondecode = try? JSONDecoder().decode(T.self, from: data!)
                completion (jsondecode, nil)
            }
                
            if (error != nil) {
                completion (nil,error?.localizedDescription)
            }
        }
        sessionTask.resume()
    }
}
