//
//  SettingCell.swift
//  pathly-vpn
//
//  Created by Александр on 08.11.2024.
//

import UIKit

enum SettingItem: CaseIterable {
    case subscription
    case restorePurchases
    case support
    case privacy
    case terms

    var title: String {
        switch self {
            case .subscription:
                return L10n.Settings.manageSubscription
            case .restorePurchases:
                return L10n.Settings.restorePurchases
            case .support:
                return L10n.Settings.helpSupport
            case .privacy:
                return L10n.Settings.privacyPolicy
            case .terms:
                return L10n.Settings.termsOfService
        }
    }
}

enum CellCorner {
    case up
    case down
    case none
}

class SettingCell: UITableViewCell {

    static let reuseIdentifier: String = "SettingCell"

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = FontFamily.Poppins.medium.font(size: 16)
        label.textColor = Asset.dark.color
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .white
        self.backgroundColor = .clear
        let hStack = ViewFactory.stack(.horizontal, spacing: 18)
        self.contentView.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: 0,
                left: 24,
                bottom: 0,
                right: 24)
            )
        }
        
        hStack.addArrangedSubview(titleLabel)
        
        let rightView = UIImageView(image: Asset.settingsRight.image)
        rightView.contentMode = .scaleAspectFit
        rightView.snp.makeConstraints { make in
            make.width.equalTo(14)
        }
        hStack.addArrangedSubview(rightView)
    }
    
    func configure(item: SettingItem) {
        self.titleLabel.text = item.title
    }


}
