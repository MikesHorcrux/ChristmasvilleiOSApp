//
//  NetworkDispatcher.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation
import Combine

struct NetworkDispatcher {
    private let urlSession: URLSession
    private let logger: NetworkingLogger

    public init(urlSession: URLSession = .shared, logger: NetworkingLogger = .init()) {
        self.urlSession = urlSession
        self.logger = logger
    }

    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest) async throws -> ReturnType {
        logger.log(request)
        
        let (data, response) = try await urlSession.data(for: request)
        
        logger.log(response, data: data)
        
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            throw httpError(httpStatusCode: response.statusCode, json: data)
        }
        
        do {
            let decodedData = try JSON.decoder.decode(ReturnType.self, from: data)
            return decodedData
        } catch {
            throw NetworkRequestError.decodingError
        }
    }

}

extension NetworkDispatcher {
/// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter httpStatusCode: HTTP status code
    /// - Parameter json?:  body of the response from api
    /// - Returns: Mapped Error
    private func httpError(httpStatusCode: Int, json: Data?) -> NetworkRequestError {
        if let error = parseError(from: json) {
            return .detailed(error)
        }
        switch httpStatusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(httpStatusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(httpStatusCode)
        default: return .unknownError
        }
    }
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }

    private func parseError( from json: Data?) -> DetailedNetworkRequestError? {
        guard let json = json else { return nil }
        return try? JSON.decoder.decode(DetailedNetworkRequestError.self, from: json)
    }
}
