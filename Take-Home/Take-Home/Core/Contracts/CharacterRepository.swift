//
//  CharacterRepository.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import Foundation
protocol CharacterRepository {
    func fetchCharacters(page: String, count:String, status: String, completion: @escaping (Result<CharactersResponse?, APIError>) -> Void)
}
