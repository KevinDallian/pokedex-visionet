//
//  ExpressAPIManager.swift
//  pokedex
//
//  Created by Kevin Dallian on 21/05/24.
//

import Foundation

class ExpressAPIManager {
    let endPoint = "http://localhost:3000/api/v1"
    
    static var shared = ExpressAPIManager()
    
    private init(){
        
    }
    
    func catchPokemon() async throws -> Bool {
        guard let url = URL(string: "\(endPoint)/catch") else {
            throw NSError(domain: "Bad URL", code: 400)
        }
        
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw NSError(domain: "Bad Request", code: 400)
            }
            
            let isCaught = try JSONDecoder().decode(CatchResponse.self, from: data)
            
            return isCaught.success
        } catch let error {
            throw error
        }
    }
}
