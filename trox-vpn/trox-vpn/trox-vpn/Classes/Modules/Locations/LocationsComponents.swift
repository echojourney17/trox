import UIKit

struct LocationsComponents {
    var viewController: UIViewController
    var presenter: LocationsPresenterInterface
    
    static func make(storageService: StorageServiceInterface, storeService: StoreServiceInterface) -> LocationsComponents {
        let viewController = LocationsViewController()
        let presenter = LocationsPresenter(
            view: viewController,
            storageService: storageService,
            storeService: storeService
        )
        viewController.presenter = presenter
        return LocationsComponents(viewController: viewController, presenter: presenter)
    }
    
}