import Foundation
import UIKit
import Combine
import SkarbSDK

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    var storageService: StorageServiceInterface
    let apiService = APINetworkService()
    let storeService = StoreService()
    
    var isDeeplinkOpened: Bool = false
    var isAppActive: Bool = false
    var isDataConversionSended: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var splashPresenter: SplashPresenterInterface?
    
    init(navigationController: UINavigationController, storageService: StorageServiceInterface) {
        self.navigationController = navigationController
        self.storageService = storageService
    }
        
    func start() {
        self.showSplashFlow(completion: { [weak self] mode in
            
            switch mode {
                case .organic:
                    self?.showOrganic()
//                case .funnel(let flow):
//                    self?.showFunnel(type: flow)
            }

        })
    }
    
    private func showOrganic() {
        if self.storageService.isOnboardingShowed == false {
            self.storageService.isOnboardingShowed = true
            self.showOnboard()
        } else {
            self.showTab(autoConnect: false)
            if self.storeService.hasUnlockedPro == false {
                self.showPaywall(completion: { [weak self] in
                    self?.showPrivacyIfNeeded()
                })
            }
        }
    }
    
    private func showPrivacyIfNeeded() {
        if self.storageService.isPrivacyShowed == false {
            self.storageService.isPrivacyShowed = true
            let privacyVC = PrivacyViewController()
            privacyVC.modalPresentationStyle = .fullScreen
//            privacyVC.didDismiss = { [weak self] in
//                if self?.autoConnect == true {
//                    self?.autoConnect = false
//                    self?.vpnComponents?.presenter.powerDidTap()
//                }
//            }
            self.navigationController.present(privacyVC, animated: true)
        }
    }
    
    private func showOnboard() {
        let onboardCoordinator = OnboardCoordinator(navigationController: self.navigationController)
        onboardCoordinator.start()
        onboardCoordinator.didFinish = { [weak self] in
            self?.removeChildCoordinator(onboardCoordinator)
            self?.showTab(autoConnect: false)
            if self?.storeService.hasUnlockedPro == false {
                self?.showPaywall(completion: { [weak self] in
                    self?.showPrivacyIfNeeded()
                })
            }
        }
        self.addChildCoordinator(onboardCoordinator)
    }
    
    private func showPaywall(completion: Completion?) {
        let dismissDelay = self.storageService.remoteRespone?.dismissDelay ?? 0
        var components = PaywallComponents.make(
            storeService: self.storeService,
            apiService: self.apiService,
            storageService: self.storageService,
            type: .single(dismissDelay: dismissDelay)
        )
        components.presenter.didDismiss = {
            components.viewController.dismiss(
                animated: true,
                completion: {
                    completion?()
                }
            )
        }
        components.viewController.modalPresentationStyle = .overCurrentContext
        self.navigationController.present(components.viewController, animated: true)
    }
    
//    func showFunnel(type: FunnelFlowType) {
//        let funnelCoordinator = FunnelCoordinator(
//            navigationController: navigationController,
//            flowType: type,
//            storeService: self.storeService,
//            apiService: self.apiService
//        )
//        funnelCoordinator.delegate = self
//        addChildCoordinator(funnelCoordinator)
//        funnelCoordinator.start()
//    }
    
    private func showTab(autoConnect: Bool) {
        let tabCoordinator = TabCoordinator(
            navigationController: self.navigationController,
            storageService: self.storageService,
            storeService: self.storeService,
            apiService: self.apiService,
            autoConnect: autoConnect
        )
        tabCoordinator.start()
        self.addChildCoordinator(tabCoordinator)
    }

    func finish() {
        
    }
}

extension AppCoordinator {
    
    func showSplashFlow(completion: ((SplashMode) -> Void)?) {
        var splashComponents = SplashComponents.make(
            apiService: apiService,
            storageService: storageService,
            storeService: storeService
        )
        self.splashPresenter = splashComponents.presenter
        splashComponents.presenter.didLoadFinish = completion
        self.navigationController.setViewControllers([splashComponents.viewController], animated: false)
    }

}

extension AppCoordinator {
    
    func applicationHandlerEvent(_ event: ApplicationEvent) {
        self.childCoordinators.forEach { coordinator in
            coordinator.applicationHandlerEvent(event)
            coordinator.childCoordinators.forEach { coordinator in
                coordinator.applicationHandlerEvent(event)
            }
        }
    }

}
