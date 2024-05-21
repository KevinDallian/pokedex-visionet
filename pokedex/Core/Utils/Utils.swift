//
//  Utils.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

func capitalFirstLetter(text: String) -> String {
    return text.prefix(1).uppercased() + text.dropFirst()
}

extension Int {
    var isPrime : Bool {
        guard self >= 2 else { return false }

        for i in 2 ..< self {
            if self % i == 0 {
                return false
            }
        }

        return true
    }
}

