//
//  MockCharacterAPIClient.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import Foundation
@testable import TakeHome

class MockCharacterAPIClient: CharacterAPIClient {
    
    var shouldReturnError = false
    var errorType: APIError = .noData
    var mockData: Data?
    
    func fetchData<M: Decodable>(target: ApplicationNetworking, completion: @escaping (Result<M?, APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(errorType))
        } else if let data = mockData {
            do {
                let decodedData = try JSONDecoder().decode(M.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        } else {
            completion(.failure(.noData))
        }
    }
}
