import UIKit

struct SplashComponents {
    var viewController: UIViewController
    var presenter: SplashPresenterInterface
    
    static func make(apiService: APINetworkServiceInterface, storageService: StorageServiceInterface, storeService: StoreServiceInterface) -> SplashComponents {
        let view = SplashViewController()
        let presenter = SplashPresenter(
            view: view,
            apiService: apiService,
            storageService: storageService,
            storeService: storeService
        )
        view.presenter = presenter
        return SplashComponents(viewController: view, presenter: presenter)
    }
    
}
