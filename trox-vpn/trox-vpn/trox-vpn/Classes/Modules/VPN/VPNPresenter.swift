import Foundation
import Combine
import NetworkExtension

protocol VPNPresenterInterface: AnyObject {
    var view: VPNView? { get set }
    var didShowCountry: Completion? { get set }
    
    func powerDidTap()
    
    func resetFunnel()
    func viewDidLoad()
    func viewWillAppear()
}

class VPNPresenter {
    
    weak var view: VPNView?
    var didShowCountry: Completion?
    
    private var cancellables = Set<AnyCancellable>()
    private var currentLocation: Server? {
        didSet {
            self.view?.display(server: self.currentLocation)
        }
    }
    private var storageService: StorageServiceInterface
    private var apiService: APINetworkServiceInterface
    private var storeService: StoreServiceInterface
    private var speedService: SpeesServiceInterface = SpeedService()
    private var timer: Timer?
    
    init(view: VPNView, storageService: StorageServiceInterface, apiService: APINetworkServiceInterface, storeService: StoreServiceInterface) {
        self.view = view
        self.storageService = storageService
        self.apiService = apiService
        self.storeService = storeService
    }
    
    private func initialize() {
        
        guard let server = self.storageService.servers, server.isEmpty == false else {
            self.view?.showAlert(
                message: "Servers did not find. Please try again",
                completion: { [weak self] in
                    self?.loadServers(completion: { [weak self] servers in
                        self?.storageService.servers = servers
                        self?.initialize()
                    })
                }
            )
            return
        }
        
        let currentLocationId: String = {
            if let currentLocationId = self.storageService.currentLocationId {
                if let currentServer = self.storageService.servers?.first(where: { "\($0.id)" == currentLocationId }), currentServer.premium == true, self.storeService.hasUnlockedPro == false {
                    
                } else {
                    return currentLocationId
                }
            }
            
            if let server = self.storageService.servers?.first(where: { $0.premium == false }) {
                let serverId = "\(server.id)"
                self.storageService.currentLocationId = serverId
                return serverId
            }
            
            return ""
        }()
        
        self.currentLocation = self.storageService.servers?.first(where: { "\($0.id)" == currentLocationId })
        
    }
    
    private func onTick() {
        if VPNManager.shared.isConnectActive() {
            let date = VPNManager.shared.connectDate() ?? Date()
            self.view?.updateUI(status: .connect(date: date))
        }
    }
    
    private func loadServers(completion: (([Server]) -> Void)?) {
        self.apiService.application.servers(apiKey: Constants.apiKey).sink { completionHandler in
            switch completionHandler {
                case .failure(let error):
                    completion?([])
                default:
                    break
            }
        } receiveValue: { response in
            completion?(response)
        }.store(in: &cancellables)
    }
    
    private func speedTest() {
        self.speedService.checkForSpeedTest { [weak self] byte in
            let byteDownloadString = String(format: "%.2f", byte ?? 0.3)
            var uploadByte = (byte ?? 0.3) - Double.random(in: 0.1...0.2)
            if uploadByte < 0 {
                uploadByte = 0.1
            }
            let byteUploadString = String(format: "%.2f", uploadByte)
            
            let byteAttributed = byteDownloadString
                .attr
                .fonted(FontFamily.Poppins.bold.font(size: 16))
                .colored(.black)
            let uploadByteAttributed = byteUploadString
                .attr
                .fonted(FontFamily.Poppins.bold.font(size: 16))
                .colored(.black)
            let kbAttributed = L10n.Vpn.mbs
                .attr
                .fonted(FontFamily.Poppins.medium.font(size: 12))
                .colored(.black)
            let downloadAttrString = NSMutableAttributedString(attributedString: byteAttributed)
            downloadAttrString.append(kbAttributed)
            
            let uploadAttrString = NSMutableAttributedString(attributedString: uploadByteAttributed)
            uploadAttrString.append(kbAttributed)
            
            DispatchQueue.main.async {
                self?.view?.updateUI(
                    downloadByte: downloadAttrString,
                    uploadByte: uploadAttrString
                )
            }
        }
    }
    
    @objc func onDidVPNConnectTapped() {
        if VPNManager.shared.isDisconnected {
            connect()
        } else {
            VPNManager.shared.disconnect()
        }
    }

    private func connect() {
        if let cServer = currentLocation {
            VPNManager.shared.connectIKEv2(config: cServer) { (success) in
            } onError: { (error) in
                self.view?.showAlert(message: error, completion: nil)
            }
        } else {
            self.view?.showAlert(
                message: "Please select server of country",
                completion: nil
            )
        }
    }
    
    private func vpnStateChanged(status: NEVPNStatus) {
        switch status {
            case .invalid:
                self.view?.updateUI(status: .disconnect)
            case .disconnected, .reasserting:
                self.view?.updateUI(status: .disconnect)
            case .connected:
                let date = VPNManager.shared.connectDate() ?? Date()
                self.view?.updateUI(status: .connect(date: date))
                self.speedTest()
            case .connecting:
                self.view?.updateUI(status: .connection)
            case .disconnecting:
                self.view?.updateUI(status: .disconnect)
                self.speedTest()
            @unknown default: break
        }
    }
    
    deinit {
        self.timer?.invalidate()
    }
    
}
extension VPNPresenter: VPNPresenterInterface {
    
    func resetFunnel() {
        self.storageService.isFunnelShowed = false
    }
    
    func powerDidTap() {
        self.onDidVPNConnectTapped()
    }
    
    func viewDidLoad() {
        _ = VPNManager.shared
        vpnStateChanged(status: VPNManager.shared.status)
        VPNManager.shared.statusEvent.attach(self, VPNPresenter.vpnStateChanged)
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { [weak self] timer in
                self?.onTick()
        })
    }
    
    func viewWillAppear() {
        initialize()
    }
    
}
