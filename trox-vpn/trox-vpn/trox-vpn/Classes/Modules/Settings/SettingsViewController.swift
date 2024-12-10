//
//  SettingsViewController.swift
//  pathly-vpn
//
//  Created by Александр on 07.11.2024.
//

import UIKit
import MessageUI

protocol SettingsView: AnyObject, Paylable, Loadable, Alertable {
    var presenter: SettingsPresenterInterface? { get set }
    
    func openURL(string: String)
    func openMail(_ mail: String)
}

class SettingsViewController: UIViewController {

    var presenter: SettingsPresenterInterface?
    
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .plain)
        view.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        view.delegate = presenter
        view.dataSource = presenter
        view.separatorColor = .black.withAlphaComponent(0.8)
        view.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = L10n.settings
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        let titleLabel = ViewFactory.label(
            font: FontFamily.Poppins.medium.font(size: 16),
            color: Asset.dark.color
        )
        titleLabel.text = L10n.settings
        titleLabel.textAlignment = .center
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(tableView)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(74)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func openMailbox(email: String) {
        if MFMailComposeViewController.canSendMail() {
           let mail = MFMailComposeViewController()
           mail.mailComposeDelegate = self
           mail.setToRecipients([email])
           present(mail, animated: true)
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

extension SettingsViewController: SettingsView {
    
    func openURL(string: String) {
        if let url = URL(string: string) {
            UIApplication.shared.open(url)
        }
    }
    
    func openMail(_ mail: String) {
        self.openMailbox(email: mail)
    }

}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        controller.dismiss(animated: true)
    }
    
}
