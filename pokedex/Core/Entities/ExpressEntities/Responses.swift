//
//  CatchResponses.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

struct CatchResponse : Codable {
    let success : Bool
}

struct ReleaseResponse : Codable {
    let number : Int
}

struct RenameResponse : Codable {
    let name : String
    let renameCount : Int
}
