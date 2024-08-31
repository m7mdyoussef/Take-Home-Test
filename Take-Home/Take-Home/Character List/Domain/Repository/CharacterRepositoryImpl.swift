//
//  CharacterRepository.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import Foundation

class CharacterRepositoryImpl: CharacterRepository {
    
    private let apiClient: CharacterAPIClient

    init(apiClient: CharacterAPIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchCharacters(page: String, count: String, status: String, completion: @escaping (Result<CharactersResponse?, APIError>) -> Void) {
        let target = ApplicationNetworking.fetchCharacters(page: page, count: count, status: status)
        
        apiClient.fetchData(target: target) { (result: Result<CharactersResponse?, APIError>) in
            switch result {
            case .success(let response):
                guard let response = response else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
