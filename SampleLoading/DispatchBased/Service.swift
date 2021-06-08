//
//  Service.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation

protocol ServiceProtocol {
    func fetchCharacters(page: Int, completionHandler: @escaping (Result<[ShowCharacter], ServiceError>) -> Void)
}

class Service : ServiceProtocol {
    
    private func failure<T>(result: ServiceError, completionHandler: @escaping (Result<T, ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completionHandler(.failure(result))
        }
    }
    
    private func success<T>(result: T, completionHandler: @escaping (Result<T, ServiceError>) -> Void) {
        DispatchQueue.main.async {
            completionHandler(.success(result))
        }
    }
    
    func fetchCharacters(page: Int, completionHandler: @escaping (Result<[ShowCharacter], ServiceError>) -> Void) {
        guard let url = URL(string: String(format: "https://rickandmortyapi.com/api/character/?page=%i", page)) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard error == nil else {
                self.failure(result: .genericError, completionHandler: completionHandler)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                self.failure(result: .genericError, completionHandler: completionHandler)
                return
            }
            
            guard response.statusCode == 200 else {
                self.failure(result: .unexpectedStatusCode(statusCode: response.statusCode), completionHandler: completionHandler)
                return
            }
            
            guard let data = data else {
                self.failure(result: .genericError, completionHandler: completionHandler)
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(ServiceResponse<[ShowCharacter]>.self, from: data) else {
                self.failure(result: .errorSerializing, completionHandler: completionHandler)
                return
                
            }
            
            self.success(result: decoded.results, completionHandler: completionHandler)
        })
        
        dataTask.resume()
    }
}
