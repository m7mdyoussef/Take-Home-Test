//
//  ApplicationNetworking.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

enum ApplicationNetworking {
    case fetchCharacters(page: String, count: String, status: String)
}


extension ApplicationNetworking: TargetType {
    var baseURL: String {
        return Constants.APIConstatnts.baseURL
    }
    var path: String {
        switch self {
        case .fetchCharacters:
            return Constants.APIConstatnts.characterUrlPath
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .fetchCharacters(let page, let count, let status):
            var params = [
                Constants.APIConstatnts.page: page,
                Constants.APIConstatnts.count: count,
            ]
            if status != CharacterStatus.All.rawValue {
                params[Constants.APIConstatnts.status] = status
            }
            return .requestParameters(parameters: params)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}
