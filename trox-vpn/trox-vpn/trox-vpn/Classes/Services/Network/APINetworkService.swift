import Foundation

protocol APINetworkServiceInterface {
    var application: ApplicationNetworkServiceInterface { get set }
    var base: BaseNetworkServiceInterface { get set }
}

final class APINetworkService: APINetworkServiceInterface {
    var application: ApplicationNetworkServiceInterface = ApplicationNetworkService()
    var base: BaseNetworkServiceInterface = BaseNetworkService()
}
