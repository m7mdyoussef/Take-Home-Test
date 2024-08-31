//
//  FetchCharactersUseCase.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import Foundation

class FetchCharactersUseCaseImpl: FetchCharactersUseCase {
    private let repository: CharacterRepository

    init(repository: CharacterRepository) {
        self.repository = repository
    }

    func execute(page: String, count: String, status: String, completion: @escaping (Result<CharactersResponse?, APIError>) -> Void) {
        repository.fetchCharacters(page: page, count: count, status: status, completion: completion)
    }
}
