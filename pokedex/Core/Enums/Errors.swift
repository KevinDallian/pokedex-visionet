//
//  Errors.swift
//  pokedex
//
//  Created by Kevin Dallian on 23/05/24.
//

import Foundation

enum ScanningError : Error, LocalizedError {
    case urlNotFound
    var errorDescription: String? {
        switch self {
        case .urlNotFound:
            return "Given URL doesn't return Pokemon Data"
        }
    }
}
