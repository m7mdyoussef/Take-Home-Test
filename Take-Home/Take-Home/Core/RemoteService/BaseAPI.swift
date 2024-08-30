//
//  BaseAPI.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

// Protocol for API client
protocol APIClient {
    associatedtype T: TargetType
    // Method to fetch data with a decodable response type
    func fetchData<M: Decodable>(target: T, completion: @escaping (Result<M?, APIError>) -> Void)
    // Method to cancel any ongoing requests
    func cancelAnyRequest()
}

class BaseAPI<T: TargetType>: APIClient {
    
    func fetchData<M: Decodable>(target: T , completion: @escaping (Result<M?, APIError>) -> Void) {
        let urlString = target.baseURL + target.path
        guard let url = URL(string: urlString) else {
            completion(.failure(.general))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        if let parameters = buildParams(task: target.task), var urlComponents = URLComponents(string: urlString), !parameters.isEmpty {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            request.url = urlComponents.url
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as? URLError {
                completion(.failure(.urlError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noNetwork))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.httpError(httpResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(M.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    private func buildParams(task: Task) -> [String: Any]? {
        switch task {
        case .requestPlain:
            return nil
        case .requestParameters(parameters: let parameters):
            return parameters
        }
    }
    
    func cancelAnyRequest() {
        URLSession.shared.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
}

