//
//  PowerView.swift
//  trox-vpn
//
//  Created by Александр on 26.11.2024.
//

import UIKit

class PowerView: UIView {

    var didTap: Completion?
    
    private lazy var contentView: UIView = {
        var view = UIView()
//        view.backgroundColor = .white
        return view
    }()
    private lazy var statusLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.semiBold.font(size: 20),
            color: Asset.dark.color
        )
        label.text = "Status"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        contentView.cornered()
    }
    
    private func common() {
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(172)
        }
        
        let powerView = UIImageView(image: Asset.vpnPower.image)
        powerView.contentMode = .top
        contentView.addSubview(powerView)
        powerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).inset(32)
            make.centerX.equalToSuperview()
        }
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(onDidRecognizeTap(recognizer:))
        )
        contentView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func onDidRecognizeTap(recognizer: UITapGestureRecognizer) {
        self.didTap?()
    }
    
    func apply(status: ConnectionStatus) {
        switch status {
        case .connect:
            self.statusLabel.text = "Stop"
        case .connection:
            self.statusLabel.text = "Close"
        case .disconnect:
            self.statusLabel.text = "Start"
        case .fail:
            self.statusLabel.text = "Start"
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
