//
//  Request.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation
import Combine
import SwiftUI

public enum HTTPMethod: String {
    case get = "Get"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Request {
    associatedtype ReturnType: Codable

    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var queryParams: [String: String]? { get }
    var body: [String: Any]? { get }
    var bodyData: Data? { get }
    var headers: [String: String] { get }
    var apiVersion: Int? { get }
    
    // Implement these if you want to mock the request.
    var isMocked: Bool { get }
    func mock() async throws -> ReturnType
}

    // Defaults and Helper Methods
extension Request {
    // Defaults
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var headers: [String: String] { return [:] }
    var apiVersion: Int? { return 1 }
    var isMocked: Bool { false }
    var body: [String: Any]? {
        return nil
    }
    var bodyData: Data? {
        if let body = body {
            return requestBodyFrom(params: body)
        } else {
            return nil
        }
    }
    func mock() async throws -> ReturnType {
            fatalError("Mock not implemented")
        }
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]) -> Data? {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }

    /// Transforms an Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Parameter sharedHeaders: Additional Headers to add to the request
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String, sharedHeaders: [String: String]) -> URLRequest? {
        guard let finalURL = url(baseURL: baseURL) else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = bodyData
        request.allHTTPHeaderFields = sharedHeaders.merged(with: headers)
        return request
    }

    private func url(baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        if let apiVersion = apiVersion {
            urlComponents.path = "\(urlComponents.path)/api/v\(apiVersion)/\(path)/"
        } else {
            urlComponents.path = "\(urlComponents.path)/\(path)/"
        }
        queryParams?.forEach { key, value in
            let item = URLQueryItem(name: key, value: value)
            if urlComponents.queryItems == nil {
                urlComponents.queryItems = [item]
            } else {
                urlComponents.queryItems?.append(item)
            }
        }

        return urlComponents.url
    }
}
