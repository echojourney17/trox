//
//  CommonPaywallViewController.swift
//  pathly-vpn
//
//  Created by Александр on 10.11.2024.
//

import UIKit

typealias PaywallViewEventHandler = ((PaywallViewEvent) -> Void)
enum PaywallViewEvent {
    case dismiss
    case subscribe
    case select(productId: String)
    case terms
    case privacy
}

protocol PaywallView: AnyObject, Loadable {
    var presenter: PaywallPresenterInterface? { get set }
    
    func dismiss()
    func display(products: [ProductDTO], productDescription: String)
    func display(productDescription: String, dismissDelay: Int)
}

class CommonPaywallViewController: UIViewController {

    private var productViews: [ProductView] = []
    private lazy var titleView: UIView = {
        var vStack = ViewFactory.stack(.vertical, spacing: 16)
        
        let iconView = UIImageView(image: Asset.paywallCrown.image)
        iconView.contentMode = .bottomLeft
        iconView.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
        
        let titleLabel = ViewFactory.label(
            font: FontFamily.Poppins.medium.font(size: 24),
            color: .black
        )
        titleLabel.textAlignment = .left
        titleLabel.text = "Go Premium"
        
        let subtitleLabel = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 14),
            color: Asset.textGray.color
        )
        subtitleLabel.textAlignment = .left
        subtitleLabel.text = "Unlock the full power of this mobile tool\nand enjoy a digital experience like never!"
        subtitleLabel.numberOfLines = 0
        
        vStack.addArrangedSubview(iconView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
        
        
        return vStack
    }()
    lazy var contentStack: UIStackView = {
        var view = ViewFactory.stack(.vertical, spacing: 24)
        return view
    }()
    lazy var bottomStack: UIStackView = {
        let view = ViewFactory.stack(.vertical, spacing: 8)
        return view
    }()
    lazy var descriptionLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 16),
            color: Asset.textGray.color
        )
        label.textAlignment = .center
        label.text = "Description"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    private lazy var dismissButton: UIButton = {
        let dismissButton = UIButton(type: .system)
        dismissButton.tintColor = .black
        dismissButton.setImage(Asset.utillityDismiss.image, for: .normal)
        dismissButton.addAction(UIAction(handler: { [weak self] actions in
            self?.presenter?.didEvent?(.dismiss)
        }), for: .touchUpInside)
        return dismissButton
    }()
    
    var presenter: PaywallPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        let backgroundView = UIImageView(image: Asset.onboardBackground.image)
        backgroundView.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(75)
        }
        
        let vStack = ViewFactory.stack(.vertical, spacing: 40)
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.right.top.equalToSuperview()
            make.size.equalTo(44)
        }
        
        let actionButton = ViewFactory.Buttons.main(title: "Start & Subscribe")
        actionButton.addAction(UIAction(handler: { [weak self] action in
            self?.presenter?.pay()
        }), for: .touchUpInside)
        actionButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        let hStack = ViewFactory.stack(.horizontal, spacing: 8)
        let termsButton = UIButton(type: .system)
        termsButton.titleLabel?.font = FontFamily.Poppins.regular.font(size: 16)
        termsButton.setTitleColor(Asset.textGray.color, for: .normal)
        termsButton.setTitle("Terms of use", for: .normal)
        termsButton.addAction(UIAction(handler: { [weak self] action in
            self?.presenter?.didEvent?(.terms)
        }), for: .touchUpInside)
        
        let privacyButton = UIButton(type: .system)
        privacyButton.titleLabel?.font = FontFamily.Poppins.regular.font(size: 16)
        privacyButton.setTitleColor(Asset.textGray.color, for: .normal)
        privacyButton.setTitle("Privacy Policy", for: .normal)
        privacyButton.addAction(UIAction(handler: { [weak self] action in
            self?.presenter?.didEvent?(.privacy)
        }), for: .touchUpInside)
        
        hStack.addArrangedSubview(termsButton)
        hStack.addArrangedSubview(UIView())
        hStack.addArrangedSubview(privacyButton)
        
        hStack.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        bottomStack.addArrangedSubview(actionButton)
        bottomStack.addArrangedSubview(hStack)
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        let containerContentStack = UIView()
        containerContentStack.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        vStack.addArrangedSubview(titleView)
        vStack.addArrangedSubview(containerContentStack)
        vStack.addArrangedSubview(bottomStack)
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

extension CommonPaywallViewController: PaywallView {
    
    func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    func display(products: [ProductDTO], productDescription: String) {
        contentStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.productViews.removeAll()
        
        contentStack.spacing = 10
        products.forEach { product in
            let productView = ProductView()
            productView.configure(product: product)
            productView.didAction = { [weak self] in
                self?.presenter?.productDidSelect(id: product.id)
            }
            productView.snp.makeConstraints { make in
                make.height.equalTo(78)
            }
            contentStack.addArrangedSubview(productView)
            self.productViews.append(productView)
        }
        self.descriptionLabel.text = productDescription

    }
    
    func display(productDescription: String, dismissDelay: Int) {
        self.descriptionLabel.text = productDescription
        self.dismissButton.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(dismissDelay), execute: {
            self.dismissButton.isHidden = false
        })
    }
    
}
