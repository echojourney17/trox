//
//  SplashViewController.swift
//  trox-vpn
//
//  Created by Александр on 22.11.2024.
//

import UIKit

protocol SplashView: AnyObject {
    var presenter: SplashPresenterInterface? { get set }
    
    func updateUI(mode: SplashMode)
}

class SplashViewController: UIViewController {

    var presenter: SplashPresenterInterface?
    
    private lazy var activityView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.view.backgroundColor = .black
    }
    
    private func organicSetupUI() {
        let backImageView = UIImageView(image: Asset.splashBackground.image)
        self.view.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let logoView = UIImageView(image: Asset.splashLogo.image)
        self.view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = L10n.Splash.description
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            self.presenter?.viewDidFinish()
        }
    }
    
    private func funnelSetupUI() {
        self.view.addSubview(self.activityView)
        self.activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(134)
        }
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

extension SplashViewController: SplashView {
    
    func updateUI(mode: SplashMode) {
        switch mode {
            case .organic:
                self.organicSetupUI()
            case .funnel:
                self.funnelSetupUI()
        }
    }
    
}
