//
//  VPNViewController.swift
//  trox-vpn
//
//  Created by Александр on 23.11.2024.
//

import UIKit

protocol VPNView: AnyObject, Alertable {
    var presenter: VPNPresenterInterface? { get set }
    
    func updateUI(downloadByte: NSAttributedString, uploadByte: NSAttributedString)
    func display(server: Server?)
    func updateUI(status: ConnectionStatus)
    func animate()
}


class VPNViewController: UIViewController {
    
    var presenter: VPNPresenterInterface?
    
    private lazy var powerView: PowerView = {
        var view = PowerView()
        return view
    }()
    private lazy var statusView: VPNStatusView = {
        var view = VPNStatusView()
        return view
    }()
    private lazy var countryIconView: UIImageView = {
        var view = UIImageView()
        return view
    }()
    private lazy var countryView: CountryView = {
        var view = CountryView()
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(onDidTapCountry)
        )
        view.addGestureRecognizer(tapRecognizer)
        
        return view
    }()
    private lazy var checkNetworkView: CheckNetworkView = {
        var view = CheckNetworkView()
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.countryIconView.layoutIfNeeded()
        self.countryIconView.cornered()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setupUI() {
        let backImageView = UIImageView(image: Asset.vpnBackground.image)
        self.view.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let topView = UIImageView(image: Asset.vpnBackgroundLeaf.image)
        self.view.addSubview(topView)
        topView.contentMode = .scaleAspectFill
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        let bottomView = UIView()
        let bottomHeight = UIScreen.main.bounds.height * 0.56
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(bottomHeight)
        }
        
        let coverView = UIImageView(image: Asset.vpnCover.image)
        bottomView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        let navView: UIView = {
            let view = UIView()
            let label = ViewFactory.label(
                font: FontFamily.Poppins.semiBold.font(size: 28),
                color: .white
            )
            label.text = "TroxVPN"
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            view.addSubview(countryIconView)
            countryIconView.snp.makeConstraints { make in
                make.size.equalTo(26)
                make.right.equalToSuperview().inset(24)
                make.centerY.equalToSuperview()
            }
            
            return view
        }()
        self.view.addSubview(navView)
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(74)
        }
        
        let contentDetailView = UIView()
        let contentStack = ViewFactory.stack(.vertical, spacing: 32)
        bottomView.addSubview(contentDetailView)
        contentDetailView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
        contentDetailView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        contentStack.addArrangedSubview(countryView)
        contentStack.addArrangedSubview(checkNetworkView)
        
        // Power view
        self.view.addSubview(powerView)
        powerView.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView.snp.top)
            make.centerX.equalToSuperview()
        }
        
        
        // Status view
        let statusContainerView: UIView = {
            let view = UIView()
            view.addSubview(statusView)
            statusView.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            return view
        }()
        self.view.addSubview(statusContainerView)
        statusContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(navView.snp.bottom)
            make.bottom.equalTo(powerView.snp.top)
        }
        
    }
    
    private func setupBindings() {
        powerView.didTap = { [weak self] in
            self?.presenter?.powerDidTap()
        }
    }
    
    @objc
    private func onDidTapCountry() {
        self.presenter?.didShowCountry?()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VPNViewController: VPNView {
    
    func updateUI(downloadByte: NSAttributedString, uploadByte: NSAttributedString) {
        self.checkNetworkView.configureDownload(text: downloadByte)
        self.checkNetworkView.configureUpload(text: uploadByte)
    }
    
    func animate() {
//        powerView.animate()
    }
    
    func display(server: Server?) {
        if let server = server {
            self.countryView.configure(server: server)
            self.countryIconView.image = UIImage(named: server.country)
        }
    }
    
    func updateUI(status: ConnectionStatus) {
        self.statusView.configure(status: status)
        self.powerView.apply(status: status)
    }
    
}
