//
//  APIClientEnvironmentKey.swift
//  Christmasville
//
//  Created by Mike on 9/10/23.
//

import Foundation
import SwiftUI

struct APIClientEnvironmentKey: EnvironmentKey {
    static var defaultValue: APIClient = DefaultAPIClient(baseURL: Env.secret(.apiBaseURL))
}

extension EnvironmentValues {
    var apiClient: APIClient {
        get { self[APIClientEnvironmentKey.self] }
        set { self[APIClientEnvironmentKey.self] = newValue }
    }
}
