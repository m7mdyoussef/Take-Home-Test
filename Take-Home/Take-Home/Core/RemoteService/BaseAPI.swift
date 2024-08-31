//
//  BaseAPI.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

protocol CharacterAPIClient {
    func fetchData<M: Decodable>(target: ApplicationNetworking, completion: @escaping (Result<M?, APIError>) -> Void)
}

class APIClient: CharacterAPIClient {

    func fetchData<M: Decodable>(target: ApplicationNetworking, completion: @escaping (Result<M?, APIError>) -> Void) {
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
            
            // Handle network-related errors
            if let error = error as NSError? {
                switch error.code {
                case NSURLErrorTimedOut:
                    completion(.failure(.timeout))
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.noNetwork))
                default:
                    completion(.failure(.unknownError))
                }
                return
            }
            
            // Handle HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noNetwork))
                return
            }
            
            // Handle different status code ranges
            if (200...299).contains(httpResponse.statusCode) {
                // Attempt to decode the data if status is success
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let responseObject = try JSONDecoder().decode(M.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            } else {
                // Map HTTP status code to appropriate APIError
                let error = APIClient.errorType(type: httpResponse.statusCode)
                completion(.failure(error))
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

