//
//  VPNStatusView.swift
//  trox-vpn
//
//  Created by Александр on 25.11.2024.
//

import UIKit

class VPNStatusView: UIView {

    private lazy var connectionLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.semiBold.font(size: 20),
            color: .white
        )
        label.text = ""
        return label
    }()
    private lazy var timeLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.semiBold.font(size: 20),
            color: .white
        )
        label.text = ""
        label.textAlignment = .right
        return label
    }()
    private lazy var timeStatusLabel: UILabel = {
        let timeStatusLabel = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 16),
            color: .white
        )
        timeStatusLabel.textAlignment = .right
        timeStatusLabel.text = L10n.Vpn.time
        return timeStatusLabel
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        let vStack = ViewFactory.stack(.vertical, spacing: 8)
        self.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let statusStackView = ViewFactory.stack(.horizontal, spacing: 8)
        let connectionStackView = ViewFactory.stack(.horizontal, spacing: 8)
        
        vStack.addArrangedSubview(statusStackView)
        vStack.addArrangedSubview(connectionStackView)
        
        let statusLabel = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 16),
            color: .white
        )
        statusLabel.text = L10n.Vpn.status
        
        statusStackView.addArrangedSubview(statusLabel)
        statusStackView.addArrangedSubview(timeStatusLabel)
        
        connectionStackView.addArrangedSubview(connectionLabel)
        connectionStackView.addArrangedSubview(timeLabel)
    }
    
    func configure(status: ConnectionStatus) {
        self.connectionLabel.text = status.title
        self.timeLabel.text = status.time
        self.timeStatusLabel.text = status.time.isEmpty ? "" : L10n.Vpn.time
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
