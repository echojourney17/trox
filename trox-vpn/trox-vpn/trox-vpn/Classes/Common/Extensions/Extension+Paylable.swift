import Foundation
import UIKit

protocol Paylable {
    func showPaywall(storeService: StoreServiceInterface, storageService: StorageServiceInterface, type: Paywall)
}

extension Paylable where Self: UIViewController {

    func showPaywall(storeService: StoreServiceInterface, storageService: StorageServiceInterface, type: Paywall) {
        let apiService: APINetworkServiceInterface = APINetworkService()
        var components = PaywallComponents.make(
            storeService: storeService, 
            apiService: apiService, 
            storageService: storageService,
            type: type
        )
        components.viewController.modalPresentationStyle = .fullScreen
        components.presenter.didDismiss = {
            DispatchQueue.main.async {
                components.viewController.dismiss(animated: true)
            }
        }
        self.present(components.viewController, animated: true)
    }
    
}
