//
//  PrivacyViewController.swift
//  trox-vpn
//
//  Created by Александр on 26.11.2024.
//

import UIKit

class PrivacyViewController: CommonViewController {

    private lazy var textView: UITextView = {
        var view = UITextView()
        view.text = L10n.privacyPolicy
        view.font = FontFamily.Poppins.regular.font(size: 16)
        view.textColor = Asset.dark.color
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.appearance.title = L10n.Settings.privacyPolicy
        self.appearance.isNavigationHidden = false
        self.appearance.isBackButtonHidden = true
        
        let agreeButton = ViewFactory.Buttons.main(title: L10n.agree)
        agreeButton.addAction(UIAction(handler: { [weak self] action in
            self?.dismiss(animated: true)
        }), for: .touchUpInside)
        
        self.contentView.addSubview(textView)
        self.contentView.addSubview(agreeButton)
        
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(agreeButton.snp.top)
        }
        agreeButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(16)
        }
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
