//
//  APIManager.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 15-09-22.
//
import UIKit

enum Result<T> {
    case Success(T)
    case Error(String)
}

class APIManager {
    static let shared: APIManager = { 
        let manager = APIManager()
        return manager
    }()
}

extension APIManager {
    
    func call<T>(type: EndPointType, params: [String: Any]? = nil, completion: @escaping (_ result: Result<T>)->()) where T: Codable {
        
        var request = URLRequest(url: type.url)
        
        for (key, value) in type.headers ?? [:] {
            request.addValue(value as? String ?? "", forHTTPHeaderField: key)
        }
       
        request.httpMethod = type.httpMethod.rawValue
        
        if (params != nil) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params!, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
                                    
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.Error(CustomError.invalidResponse.localizedDescription))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                return completion(.Error(CustomError.invalidHttpResponseCode.localizedDescription))
            }
            
            guard let data = data else { return completion(.Error(CustomError.noDataAvailable.localizedDescription)) }
            
            do {
                let jsondecode = try JSONDecoder().decode(T.self, from: data)
                return completion(.Success(jsondecode))
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
        }
        sessionTask.resume()
    }
}


