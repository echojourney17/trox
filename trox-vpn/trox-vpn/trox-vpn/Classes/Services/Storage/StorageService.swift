import Foundation
import FirebaseRemoteConfig

protocol StorageServiceInterface {
    var isOnboardingShowed: Bool { get set }
    var isPrivacyShowed: Bool { get set }
    var isLastLaunch: Bool { get set }
    var currentLocationId: String? { get set }
    var servers: [Server]? { get set }
    var remoteRespone: RemoteResponse? { get set }
    var isRemoteLoaded: Bool { get set }
    
    func loadRemoteKeys(completion: ((RemoteResponse?) -> Void)?)
}

class StorageService {
    
    var isOnboardingShowed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isOnboardingShowed")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isOnboardingShowed")
        }
    }
    var isPrivacyShowed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isPrivacyShowed")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isPrivacyShowed")
        }
    }
    var currentLocationId: String? {
        get {
            return UserDefaults.standard.string(forKey: "currentLocationId")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentLocationId")
        }
    }
    var isLastLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLastLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLastLaunch")
        }
    }
    var servers: [Server]?
    var remoteRespone: RemoteResponse?
    var isRemoteLoaded: Bool = false
    
    func loadRemoteKeys(completion: ((RemoteResponse?) -> Void)?) {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch(withExpirationDuration: 0) { (status, error) in
            if status == .success {
                remoteConfig.activate()

                let dismissDelay = remoteConfig.configValue(forKey: "dismissDelay").numberValue
                
                let decoder = JSONDecoder()
                let languageCode = Locale.current.languageCode ?? "en"
                
                let productValue = remoteConfig.configValue(forKey: "product_subscription_\(languageCode)").dataValue
                let productLocalize: [RemoteSubscription]? = try? decoder.decode([RemoteSubscription].self, from: productValue)
                
                let remoteResponse = RemoteResponse(
                    dismissDelay: Int(truncating: dismissDelay),
                    productLocalize: productLocalize
                )

                self.remoteRespone = remoteResponse
                completion?(remoteResponse)
                return
            } else {
                completion?(nil)
                return
            }
        }
    }
}

extension StorageService: StorageServiceInterface {

}
