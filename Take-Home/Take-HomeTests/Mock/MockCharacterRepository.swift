//
//  MockCharacterRepository.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import Foundation
@testable import TakeHome

// Mock repository to simulate fetching characters
class MockCharacterRepository: CharacterRepository {
    
    var shouldReturnError = false
    var characters: [Character] = []

    func fetchCharacters(page: String, count: String, status: String, completion: @escaping (Result<TakeHome.CharactersResponse?, TakeHome.APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(TakeHome.APIError.noData))
        } else {
            let response = CharactersResponse(results: characters, info: Info(count: 1, pages: 1))
            completion(.success(response))
        }
    }
}
