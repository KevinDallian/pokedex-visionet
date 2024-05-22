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

func fibonacci(of number: Int) -> Int {
    if number <= 1 {
        return number
    }
    return fibonacci(of: number - 1) + fibonacci(of: number - 2)
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

