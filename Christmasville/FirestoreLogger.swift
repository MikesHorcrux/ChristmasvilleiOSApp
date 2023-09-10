
import Foundation
import FirebaseFirestore
import FirebaseCrashlytics
import UIKit

class FirestoreLogger {
    static func logResult<T>(_ result: Result<T, Error>, operation: String) {
        switch result {
        case .success(_):
            print("✅ \(operation) succeeded")
        case .failure(let error):
            print("❌ \(operation) failed with error: \(error.localizedDescription)")
            Crashlytics.crashlytics().record(error: error)
            logDeviceInfo()
        }
    }
    
    static func logError(_ error: Error, operation: String) {
        print("❌ \(operation) failed with error: \(error.localizedDescription)")
        Crashlytics.crashlytics().record(error: error)
        logDeviceInfo()
    }
    
    static func logDeviceInfo() {
        let device = UIDevice.current
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        let osVersion = device.systemVersion
        let deviceModel = device.model
        Crashlytics.crashlytics().setCustomValue(appVersion, forKey: "app_version")
        Crashlytics.crashlytics().setCustomValue(osVersion, forKey: "os_version")
        Crashlytics.crashlytics().setCustomValue(deviceModel, forKey: "device_model")
        print("📱 Device Info: \(deviceModel), \(osVersion)")
        print("📱 App Version: \(appVersion)")
    }
}
