//
//  MultyPaywallViewController.swift
//  pathly-vpn
//
//  Created by Александр on 10.11.2024.
//

import UIKit

class ProductView: UIView {
    
    var id: String?
    var didAction: Completion?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.bordered(color: Asset.border.color, width: 3)
        view.cornered(radius: 16)
        return view
    }()
    private lazy var titleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.medium.font(size: 18),
            color: .black
        )
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 14),
            color: .black.withAlphaComponent(0.7)
        )
        return label
    }()
    private lazy var checkView: UIImageView = {
        var view = UIImageView.init(image: Asset.locationsCheckEmpty.image)
        return view
    }()
    private lazy var priceLabel: UILabel = {
        var label = ViewFactory.label(
            font: Styles.Fonts.title,
            color: .gray
        )
        label.textAlignment = .right
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        var label = ViewFactory.label(
            font: Styles.Fonts.title,
            color: .gray
        )
        label.textAlignment = .right
        return label
    }()
    private lazy var actionButton: UIButton = {
        var button = UIButton(type: .custom)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.didAction?()
        }), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func select() {
        self.checkView.image = Asset.locationsCheckSelected.image
    }
    
    private func unselect() {
        self.checkView.image = Asset.locationsCheckEmpty.image
    }
    
    private func common() {
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let leftVStack = ViewFactory.stack(.vertical, spacing: 6)
        contentView.addSubview(leftVStack)
        leftVStack.addArrangedSubview(titleLabel)
        leftVStack.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(checkView)
        checkView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(22)
            make.centerY.equalToSuperview()
            make.size.equalTo(22)
        }
        leftVStack.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.right.equalTo(checkView.snp.left).inset(8)
        }
        
        contentView.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(product: ProductDTO) {
        self.id = product.id
        self.titleLabel.text = product.name
        self.subtitleLabel.text = product.localizedPrice
        
        product.isSelected ? self.select() : self.unselect()
    }
    
}

class MultyPaywallViewController: CommonPaywallViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        
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

