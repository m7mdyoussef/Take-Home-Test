//
//  CharacterAPIClient.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import Foundation

protocol CharacterAPIClient {
    func fetchData<M: Decodable>(target: ApplicationNetworking, completion: @escaping (Result<M?, APIError>) -> Void)
}
