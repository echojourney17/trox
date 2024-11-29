import Foundation
import Combine
import FirebaseRemoteConfig

protocol SplashPresenterInterface {
    var view: SplashView? { get set }
    var didLoadFinish: ((SplashMode) -> Void)? { get set }
    
//    func showFunnel(type: FunnelFlowType)
    func showOrganic()
    
    func viewDidLoad()
    func viewDidFinish()
}

struct RemoteResponse {
//    var appkey1: String?
//    var appkey2: String?
    var dismissDelay: Int
//    var scanFlow: FunnelModel?
//    var checkFlow: FunnelModel?
    var productLocalize: [RemoteSubscription]?
    
//    var keys: [String] {
//        var k: [String] = []
//        if let appkey1 = appkey1 {
//            k.append(appkey1)
//        }
//        if let appkey2 = appkey2 {
//            k.append(appkey2)
//        }
//        return k
//    }
}

struct RemoteSubscription: Codable {
    var productId: String
    var description: String
    var name: String
}

enum SplashMode {
    case organic
//    case funnel(flow: FunnelFlowType)
}

class SplashPresenter {
    weak var view: SplashView?
    var didLoadFinish: ((SplashMode) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    private var apiService: APINetworkServiceInterface
    private var storageService: StorageServiceInterface
    private var storeService: StoreServiceInterface
    private var group: DispatchGroup = DispatchGroup()
    
    private var mode: SplashMode = .organic
    
    init(view: SplashView, apiService: APINetworkServiceInterface, storageService: StorageServiceInterface, storeService: StoreServiceInterface) {
        self.view = view
        self.apiService = apiService
        self.storageService = storageService
        self.storeService = storeService
    }
    
    private func getServers(completion: ((Result<[Server], ErrorResponse>) -> Void)?) {
        self.apiService.application.servers(apiKey: Constants.apiKey).sink { completionHandler in
            switch completionHandler {
                case .failure(let error):
                    completion?(.failure(error))
                default:
                    break
            }
        } receiveValue: { response in
            completion?(.success(response))
        }.store(in: &cancellables)
    }

    private func load() {
        group.enter()
        
        self.getServers { [weak self] result in
            switch result {
            case .success(let servers):
                self?.storageService.servers = servers
            case .failure(let error):
                break
            }
            self?.group.leave()
        }
        
        group.enter()
        self.storeService.load { [weak self] in
            self?.group.leave()
        }
        
        self.group.enter()
        self.storageService.loadRemoteKeys(completion: { [weak self] remoteConfig in
            self?.group.leave()
        })

        group.notify(queue: .main, execute: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.didLoadFinish?(strongSelf.mode)
        })
    }
    
}

extension SplashPresenter: SplashPresenterInterface {

    func showOrganic() {
        group.enter()
        self.mode = .organic
        self.view?.updateUI(mode: .organic)
        self.load()
    }
    
    func viewDidLoad() {
        self.load()
    }
    
    func viewDidFinish() {
        group.leave()
    }
    
}
