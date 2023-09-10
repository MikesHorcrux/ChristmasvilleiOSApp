//
//  NetworkingLogger.swift
//  JuC
//
//  Created by Mike on 4/2/23.
//

import Foundation
import OSLog

import Foundation
import os.log

struct NetworkingLogger {
    private let logger: Logger
    private let queue: DispatchQueue

    init(logger: Logger = .init(),
         queue: DispatchQueue = .init(label: "\(Self.self)Queue")) {
        self.logger = logger
        self.queue = queue
    }

    func log(_ request: URLRequest) {
        queue.async {
            guard let url = request.url?.absoluteString,
                  let method = request.httpMethod
            else {
                self.logger.error("Failed to log request: invalid URL or HTTP method")
                return
            }

            self.logger.debug("""
                \(method) \(url):
                \(request.curl ?? "")
                """)
        }
    }

    func log(_ response: URLResponse, data: Data) {
        queue.async {
            guard let response = response as? HTTPURLResponse,
                  let url = response.url?.absoluteString
            else {
                self.logger.error("Failed to log response: invalid URL or HTTP response")
                return
            }

            self.logger.info("""
                \(response.statusCode) \(url):
                \(self.headerLog(headers: response.allHeaderFields))
                \(self.dataLog(data) ?? "{}")
                """)
        }
    }

    private func headerLog(headers: [AnyHashable: Any]) -> String {
        var output = "Headers: ["

        for (key, value) in headers {
            output.append("\n  \(key): \(value)")
        }

        output.append("\n]")
        return output
    }

    private func dataLog(_ data: Data) -> String? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let prettyData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8)
        } catch {
            self.logger.error("Failed to serialize data into JSON: \(error.localizedDescription)")
            return String(data: data, encoding: .utf8)
        }
    }
}
