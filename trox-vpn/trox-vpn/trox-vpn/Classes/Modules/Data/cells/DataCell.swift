//
//  DataCell.swift
//  pathly-vpn
//
//  Created by Александр on 08.11.2024.
//

import UIKit

enum DataItem: CaseIterable {
    case ip
    case location
    case postal
    case country
    
    var icon: UIImage? {
        switch self {
        case .ip:
            return Asset.settingsIp.image
        case .location:
            return Asset.settingsLocations.image
        case .postal:
            return Asset.settingsPostal.image
        case .country:
            return Asset.settingsCountry.image
        }
    }
    var title: String {
        switch self {
            case .ip:
                return L10n.Data.ipAddress
            case .location:
                return L10n.Data.location
            case .postal:
                return L10n.Data.postalCode
            case .country:
                return L10n.Data.countryCode
        }
    }
}

class DataCell: UITableViewCell {

    static let reuseIdentifier: String = "DataCell"
    
    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .top
        view.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        return view
    }()
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = FontFamily.Poppins.medium.font(size: 16)
        label.textColor = Asset.dark.color
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 16),
            color: Asset.textGray.color
        )
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
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        let hStack = ViewFactory.stack(.horizontal, spacing: 12)
        self.contentView.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: 0,
                left: 16,
                bottom: 0,
                right: 14)
            )
        }
        
        let iconContainerView = UIView()
        iconContainerView.addSubview(iconView)
        iconContainerView.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview()
        }
        
        hStack.addArrangedSubview(iconContainerView)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(descriptionLabel)
    }
    
    func configure(item: MetaInfoDTO) {
        self.iconView.image = item.item.icon
        self.titleLabel.text = item.item.title
        self.descriptionLabel.text = item.dataString
    }

}
