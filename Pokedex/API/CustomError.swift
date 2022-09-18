//
//  CustomError.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import Foundation

enum CustomError: Error {
    case noDataAvailable
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noDataAvailable:
            return NSLocalizedString(
                "Se ha producido un error con los datos",
                comment: "No data available"
            )

        }
    }
}
