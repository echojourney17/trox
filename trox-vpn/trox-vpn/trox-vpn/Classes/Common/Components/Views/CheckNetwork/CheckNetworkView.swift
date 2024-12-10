//
//  CheckNetworkView.swift
//  trox-vpn
//
//  Created by Александр on 25.11.2024.
//

import UIKit

enum CheckNetworkMode {
    case upload
    case download
    
    var title: String {
        switch self {
            case .upload:
                return L10n.CheckNetwork.upload
            case .download:
                return L10n.CheckNetwork.download
        }
    }
    var icon: UIImage? {
        switch self {
        case .upload:
            return Asset.networkUpload.image
        case .download:
            return Asset.networkDownload.image
        }
    }
}

class CheckNetworkItemView: UIView {
    
    private lazy var modeIconView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        return view
    }()
    private lazy var modeLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 16),
            color: Asset.textGray.color
        )
        label.textAlignment = .center
        return label
    }()
    private lazy var valueLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.bold.font(size: 25),
            color: .black
        )
        label.text = "-"
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        let hStack = ViewFactory.stack(.horizontal, spacing: 10)
        let vStack = ViewFactory.stack(.vertical, spacing: 2)
        
        hStack.addArrangedSubview(modeIconView)
        hStack.addArrangedSubview(vStack)

        vStack.addArrangedSubview(valueLabel)
        vStack.addArrangedSubview(modeLabel)
        
        self.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(mode: CheckNetworkMode) {
        self.modeLabel.text = mode.title
        self.modeIconView.image = mode.icon
    }
    
    func display(value: NSAttributedString) {
        self.valueLabel.attributedText = value
    }
    
}

class CheckNetworkView: UIView {

    private lazy var uploadView: CheckNetworkItemView = {
        var view = CheckNetworkItemView()
        view.configure(mode: .upload)
        return view
    }()
    private lazy var downloadView: CheckNetworkItemView = {
        var view = CheckNetworkItemView()
        view.configure(mode: .download)
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
        let hStack = ViewFactory.stack(.horizontal, spacing: 0)
        hStack.distribution = .fill
        
        let uploadContainerView = UIView()
        let downloadContainerView = UIView()
        
        uploadContainerView.addSubview(uploadView)
        downloadContainerView.addSubview(downloadView)
        
        uploadView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        downloadView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = Asset.dark.color.withAlphaComponent(0.8)
        separatorView.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        
        hStack.addArrangedSubview(downloadContainerView)
        hStack.addArrangedSubview(separatorView)
        hStack.addArrangedSubview(uploadContainerView)
        
        downloadContainerView.snp.makeConstraints { make in
            make.width.equalTo(uploadContainerView.snp.width)
        }
        
        contentView.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureDownload(text: NSAttributedString) {
        self.downloadView.display(value: text)
    }
    
    func configureUpload(text: NSAttributedString) {
        self.uploadView.display(value: text)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
