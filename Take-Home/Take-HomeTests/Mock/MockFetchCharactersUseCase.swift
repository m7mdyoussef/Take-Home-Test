//
//  MockFetchCharactersUseCase.swift
//  Take-HomeTests
//
//  Created by JOE on 31/08/2024.
//

import Foundation
@testable import TakeHome

// Mock FetchCharactersUseCase
class MockFetchCharactersUseCase: FetchCharactersUseCase {
    var shouldReturnError = false
    var mockResult: CharactersResponse?

    func execute(page: String, count: String, status: String, completion: @escaping (Result<CharactersResponse?, APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.general))
        } else {
            completion(.success(mockResult))
        }
    }
}
