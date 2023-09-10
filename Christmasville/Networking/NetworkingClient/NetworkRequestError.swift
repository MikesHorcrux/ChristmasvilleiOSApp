//
//  NetworkRequestError.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
    case detailed(DetailedNetworkRequestError)

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Please sign in to continue..."
        case .detailed(let error):
            return error.localizedDescription
        default:
            return "There seems to be a problem. Please contact support."
        }
    }

    var isUnexpected: Bool {
        switch self {
        case .unauthorized, .detailed:
            return false
        default:
            return true
        }
    }
}

struct DetailedNetworkRequestError: Codable, Equatable, LocalizedError {
    var detail: String
    var errorDescription: String? {
        return detail
    }
}
