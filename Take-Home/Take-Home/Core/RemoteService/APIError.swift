//
//  APIError.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

enum APIError: Error {
    case general
    case timeout
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case redirection
    case clientError
    case invalidResponse(httpStatusCode: Int)
    case decodingError
    case unauthorizedClient
}

extension APIError {
    var desc: String {
        switch self {
        case .general:                    return MessageHelper.ServerError.general
        case .timeout:                    return MessageHelper.ServerError.timeOut
        case .pageNotFound:               return MessageHelper.ServerError.notFound
        case .noData:                     return MessageHelper.ServerError.notFound
        case .noNetwork:                  return MessageHelper.ServerError.noInternet
        case .unknownError:               return MessageHelper.ServerError.general
        case .serverError:                return MessageHelper.ServerError.serverError
        case .redirection:                return MessageHelper.ServerError.redirection
        case .clientError:                return MessageHelper.ServerError.clientError
        case .invalidResponse:            return MessageHelper.ServerError.invalidResponse
        case .unauthorizedClient:         return MessageHelper.ServerError.unauthorizedClient
        case .decodingError:              return MessageHelper.ServerError.decodingError
        }
    }
}

extension APIClient {
    static func errorType(type: Int) -> APIError {
        switch type {
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return otherErrorType(type: type)
        }
    }
    
    private static func otherErrorType(type: Int) -> APIError {
        switch type {
        case -1001:
            return .timeout
        case -1009:
            return .noNetwork
        default:
            return .unknownError
        }
    }
}

extension APIError: Equatable{
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.general, .general),
            (.timeout, .timeout),
            (.pageNotFound, .pageNotFound),
            (.noData, .noData),
            (.noNetwork, .noNetwork),
            (.unknownError, .unknownError),
            (.serverError, .serverError),
            (.redirection, .redirection),
            (.clientError, .clientError),
            (.decodingError, .decodingError),
            (.unauthorizedClient, .unauthorizedClient):
            return true
        case (.invalidResponse(let lhsCode), .invalidResponse(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}

