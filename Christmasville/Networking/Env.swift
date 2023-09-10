import Foundation

struct Env {
    static var shouldLaunchApp: Bool {
        !bool(for: .isUnitTesting)
    }

    static func secret(_ key: SecretKey) -> String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            fatalError("Could not find Secrets.plist")
        }
        guard let secrets = NSDictionary(contentsOfFile: path) else {
            fatalError("Could not create dictionary from Secrets.plist")
        }
        guard let rawValue = secrets[key.rawValue] else {
            fatalError("Could not find value for secret key: \(key.rawValue)")
        }
        guard let value = rawValue as? String else {
            fatalError("Could not cast \(rawValue) for key \(key.rawValue) to type \(String.self)")
        }
        return value
    }

    enum SecretKey: String {
        case apiBaseURL = "API_BASE_URL"
        case applePayMerchantId = "APPLE_PAY_MERCHANT_ID"
    }

    enum LaunchArgument: String {
        case isUnitTesting = "IS_UNIT_TESTING"
    }

    private static func bool(for argument: LaunchArgument) -> Bool {
        ProcessInfo.processInfo.arguments.contains(argument.rawValue)
    }
}
