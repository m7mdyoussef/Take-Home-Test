//
//  TargetType.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//wrapper for my reqeust parameter
enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any])
}
//wrapper that carries request properties
protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}
