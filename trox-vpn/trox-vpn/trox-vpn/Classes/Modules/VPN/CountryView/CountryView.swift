//
//  CountryView.swift
//  trox-vpn
//
//  Created by Александр on 25.11.2024.
//

import UIKit

class CountryView: UIView {

    private lazy var titleLabel: UILabel = {
        var label = ViewFactory.label(
            font: FontFamily.Poppins.semiBold.font(size: 20),
            color: Asset.dark.color
        )
        label.text = "Germany"
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
        let vStack = ViewFactory.stack(.vertical, spacing: 8)
        let hStack = ViewFactory.stack(.horizontal, spacing: 8)
        
        let label = ViewFactory.label(
            font: FontFamily.Poppins.regular.font(size: 16),
            color: Asset.textGray.color
        )
        label.text = "Locations"
        
        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(hStack)
        
        let rightView = UIImageView(image: Asset.settingsRight.image)
        rightView.contentMode = .scaleAspectFit
        
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(rightView)
        
        rightView.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        
        self.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(server: Server) {
        self.titleLabel.text = server.name
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
