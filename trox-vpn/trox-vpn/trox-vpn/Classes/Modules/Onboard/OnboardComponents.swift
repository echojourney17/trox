import UIKit
import Foundation

struct OnboardComponents {
    var viewController: UIViewController
    var presenter: OnboardPresenterInterface
    
    static func make() -> OnboardComponents {
        let vc = OnboardViewController()
        let presenter = OnboardPresenter(view: vc)
        vc.presenter = presenter
        return OnboardComponents(viewController: vc, presenter: presenter)
    }
    
}
