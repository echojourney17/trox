//
//  CommonViewController.swift
//  trox-vpn
//
//  Created by Александр on 25.11.2024.
//

import UIKit

class CommonViewController: UIViewController {

    struct Appearance {
        var title: String?
        var isNavigationHidden: Bool
        var isBackButtonHidden: Bool
        
        static func make() -> Appearance {
            return Appearance(
                title: nil,
                isNavigationHidden: true,
                isBackButtonHidden: false
            )
        }
    }
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = FontFamily.Poppins.medium.font(size: 16)
        label.textColor = Asset.dark.color
        label.textAlignment = .center
        return label
    }()
    private lazy var backButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(
            Asset.utillityBack.image,
            for: .normal
        
        )
        button.tintColor = Asset.dark.color
        button.addAction(UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        return button
    }()
    private lazy var navBarView: UIView = {
        var view = UIView()
        
        let contentView = UIView()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(32)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview()
        }
        view.snp.makeConstraints { make in
            make.height.equalTo(74)
        }
        
        return view
    }()
    var contentView: UIView = {
        var view = UIView()
        return view
    }()
    var appearance: Appearance = .make() {
        didSet {
            self.titleLabel.text = self.appearance.title ?? ""
            self.navBarView.isHidden = self.appearance.isNavigationHidden
            self.backButton.isHidden = self.appearance.isBackButtonHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        let contentStack = ViewFactory.stack(.vertical, spacing: 0)
        self.view.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        contentStack.addArrangedSubview(navBarView)
        contentStack.addArrangedSubview(contentView)
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
