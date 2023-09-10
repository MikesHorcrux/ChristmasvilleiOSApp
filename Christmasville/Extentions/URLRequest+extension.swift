import Foundation

extension URLRequest {
    var curl: String {
        let newLine = " \\\n"
        return "curl " + curlComponents.map(\.option).joined(separator: newLine)
    }

    var curlComponents: [CurlComponent] {
        var components: [CurlComponent] = [
            .url(url),
            .method(httpMethod)
        ]

        if let httpHeaders = self.allHTTPHeaderFields, !httpHeaders.keys.isEmpty {
            for (key, value) in httpHeaders {
                components.append(.header(key: key, value: value))
            }
        }

        if let body = httpBody, let bodyString = String(data: body, encoding: .utf8), !bodyString.isEmpty {
            components.append(.body(bodyString))
        }

        return components
    }

    enum CurlComponent {
        case url(URL?)
        case method(String?)
        case header(key: String, value: String)
        case body(String)

        var option: String {
            switch self {
            case .url(let url):
                return "-i '\(url?.absoluteString ?? "")'"
            case .method(let method):
                return "-X \(method ?? "GET")"
            case .header(let key, let value):
                return "-H '\(key): \(value)'"
            case .body(let data):
                return "--data '\(data)'"
            }
        }
    }
}
