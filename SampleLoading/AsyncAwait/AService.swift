//
//  AService.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation


protocol AServiceProtocol {
    func fetchCharacters(page: Int) async throws -> [ShowCharacter]
}

@available(iOS 15.0, *)
class AService : AServiceProtocol {
    
    func fetchCharacters(page: Int) async throws -> [ShowCharacter] {
        
        print("-fetchCharacters async/await thread:", Thread.current)
        
        guard let url = URL(string: String(format: "https://rickandmortyapi.com/api/character/?page=%i", page)) else {
            throw ServiceError.genericError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print("-fetchCharacters async/await thread post fetch:", Thread.current)
        
        guard let response = response as? HTTPURLResponse else {
            throw ServiceError.genericError
        }
        
        guard response.statusCode == 200 else {
            throw ServiceError.unexpectedStatusCode(statusCode: response.statusCode)
        }
        
        guard let decoded = try? JSONDecoder().decode(ServiceResponse<[ShowCharacter]>.self, from: data) else {
            throw ServiceError.errorSerializing
        }
        
        return decoded.results
    }
}
