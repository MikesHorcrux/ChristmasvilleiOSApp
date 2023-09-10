import Foundation

// Protocol that defines the structure for an API client
protocol APIClient {
    var accessToken: String? { get }
    func assign(accessToken: String)
    func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType
}

// Default API client implementation
final class DefaultAPIClient: APIClient {
    // Singleton instance for the API client with the base URL retrieved from environment variables
    static let shared = DefaultAPIClient(baseURL: Env.secret(.apiBaseURL))
    
    private let baseURL: String
    private let networkDispatcher: NetworkDispatcher
    
    // Default headers for the API requests
    private var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    // Initialization with optional network dispatcher parameter with a default value
    init(baseURL: String, networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    
    // Access token property retrieved from the headers dictionary
    var accessToken: String? {
        headers["Authorization"]
    }
    
    // Method to assign a new access token
    func assign(accessToken: String) {
        headers["Authorization"] = "Bearer \(accessToken)"
    }
    
    // Asynchronous method to dispatch a network request using generics to allow different request and return types
    func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType {
        // Handling mocked requests
        guard !request.isMocked else {
            return try await request.mock()
        }
        
        // Creating a URL request with the necessary headers
        guard let urlRequest = request.asURLRequest(baseURL: baseURL, sharedHeaders: headers) else {
            throw NetworkRequestError.badRequest
        }
        
        // Dispatching the network request using the network dispatcher
        return try await networkDispatcher.dispatch(request: urlRequest)
    }
}

#if DEBUG

// API client implementation for in-memory testing (only active in DEBUG mode)
final class InMemoryAPIClient: APIClient {
    var accessToken: String?

    // Dictionary to store mocked responses keyed by request type as String
    private var responseByRequest: [String: Any] = [:]
    // Dictionary to store performed requests keyed by request type as String
    private var performedRequests: [String: Any] = [:]

    // Method to retrieve the last performed request of a specific type
    func lastPerformed<R: Request>(_ request: R.Type) -> R? {
        performedRequests["\(request)"] as? R
    }

    // Method to set a mocked response for a specific request type
    func respond<R: Request, A>(to request: R.Type, with response: A) where R.ReturnType == A {
        responseByRequest["\(request)"] = response
    }

    // Method to assign a new access token
    func assign(accessToken: String) {
        self.accessToken = accessToken
    }

    // Asynchronous method to dispatch a network request in the in-memory client, using the stored mocked responses
    func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType {
        performedRequests[key(for: request)] = request
        
        // Returning the mocked response if it exists, or throwing an error if it does not
        if let response = responseByRequest[key(for: request)] as? R.ReturnType {
            return response
        } else {
            throw NetworkRequestError.notFound
        }
    }
    
    // Helper method to generate a dictionary key for a given request
    private func key<R: Request>(for request: R) -> String {
        String(describing: type(of: request))
    }
}

#endif
