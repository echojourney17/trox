//
//  SettingsPresenter.swift
//  pathly-vpn
//
//  Created by Александр on 08.11.2024.
//

import UIKit

protocol SettingsPresenterInterface: UITableViewDelegate, UITableViewDataSource {
    var view: SettingsView? { get set }
}

class SettingsPresenter: NSObject {
    weak var view: SettingsView?
    private var items: [SettingItem] = SettingItem.allCases
    private var storeService: StoreServiceInterface
    private var storageService: StorageServiceInterface
    
    init(view: SettingsView, storeService: StoreServiceInterface, storageService: StorageServiceInterface) {
        self.view = view
        self.storeService = storeService
        self.storageService = storageService
    }
    
    private func handleDidSelect(item: SettingItem) {
        switch item {
            case .subscription:
                self.view?.showPaywall(
                    storeService: self.storeService, 
                    storageService: self.storageService,
                    type: .multy
                )
            case .restorePurchases:
                self.restore()
            case .support:
                self.view?.openMail(Constants.Support.email)
            case .privacy:
                self.view?.openURL(string: Constants.Support.policy)
            case .terms:
                self.view?.openURL(string: Constants.Support.terms)
        }
    }
    
    private func restore() {
        self.view?.startLoading()
        self.storeService.restore { [weak self] in
            DispatchQueue.main.async {
                self?.view?.stopLoading()
                self?.view?.showAlert(message: "Restore successfull", completion: nil)
            }
        }
    }
    
}

extension SettingsPresenter: SettingsPresenterInterface {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier) as? SettingCell {
            let item = self.items[indexPath.row]
            cell.configure(item: item)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        self.handleDidSelect(item: item)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

}
