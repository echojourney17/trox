//
//  LocationsViewController.swift
//  trox-vpn
//
//  Created by Александр on 25.11.2024.
//

import UIKit

protocol LocationsView: AnyObject, Paylable {
    var presenter: LocationsPresenterInterface? { get set }
    
    func reload()
    func hideKeyboard()
}

class LocationsViewController: CommonViewController {

    var presenter: LocationsPresenterInterface?
    
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseIdentifier)
        view.dataSource = presenter
        view.delegate = presenter
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func setupUI() {
        self.appearance.title = L10n.Vpn.locations
        self.appearance.isNavigationHidden = false
        
        self.contentView.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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

extension LocationsViewController: LocationsView {
    
    func reload() {
        self.tableView.reloadData()
    }
    
    func hideKeyboard() {
        //
    }
    
}
