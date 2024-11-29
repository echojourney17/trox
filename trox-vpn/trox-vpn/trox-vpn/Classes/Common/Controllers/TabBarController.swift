//
//  TabBarController.swift
//  trox-vpn
//
//  Created by Александр on 23.11.2024.
//

import UIKit

class TabbarView: UIView {
    
    var didSelect: ((Int) -> Void)?
    
    private lazy var hStackView: UIStackView = {
        var view = ViewFactory.stack(.horizontal, spacing: 32)
        view.distribution = .fillEqually
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        let contentView = UIView()
        contentView.cornered(radius: 16)
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        
        let backImageView = UIImageView(image: Asset.tabBackground.image)
        backImageView.contentMode = .scaleAspectFill
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 20
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(items: [TabItem]) {
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .system)
            button.setImage(item.icon, for: .normal)
            button.cornered(radius: 21)
            button.tintColor = .white
            button.tag = index
            button.addTarget(
                self,
                action: #selector(onDidTapTabItem(sender:)),
                for: .touchUpInside
            )
            button.snp.makeConstraints { make in
                make.size.equalTo(42)
            }
            self.hStackView.addArrangedSubview(button)
        }
    }
    
    func updateUI(selectedIndex: Int) {
        self.hStackView.arrangedSubviews.forEach { button in
            if button.tag == selectedIndex {
                button.backgroundColor = .white.withAlphaComponent(0.2)
            } else {
                button.backgroundColor = .clear
            }
        }
    }
    
    @objc
    private func onDidTapTabItem(sender: UIButton) {
        self.didSelect?(sender.tag)
    }
    
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override var selectedIndex: Int {
        didSet {
            self.customTabBarView.updateUI(selectedIndex: selectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .clear
        self.tabBar.tintColor = .clear
        
        addCustomTabBarView()
        hideTabBarBorder()

        self.customTabBarView.didSelect = { [weak self] index in
            self?.selectedIndex = index
        }
        // Do any additional setup after loading the view.
    }
    
    private lazy var customTabBarView: TabbarView = {
        var view = TabbarView()
        return view
    }()

    private func addCustomTabBarView() {
        self.tabBar.isHidden = true
        self.view.addSubview(customTabBarView)
        customTabBarView.snp.makeConstraints { make in
            make.top.equalTo(self.tabBar.snp.top)
            make.centerX.equalToSuperview()
        }
    }
    
    func set(items: [TabNavigationController]) {
        self.customTabBarView.set(items: items.map({ $0.tabItem }))
        self.setViewControllers(items, animated: false)
    }
    
    func hideTabBarBorder()  {
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
//        self.tabBar.clipsToBounds = true
    }
//    
//    func setupTabBar() {
////        self.setViewControllers([tab1, tab2, tab3], animated: false)
//        self.viewDidLayoutSubviews()
//    }
//    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
