//
//  DataViewController.swift
//  pathly-vpn
//
//  Created by Александр on 07.11.2024.
//

import UIKit

protocol DataView: AnyObject {
    var presenter: DataPresenterInterface? { get set }
    
    func display(checkButtonEnable: Bool)
    func reloadData()
}

class DataViewController: UIViewController {

    var presenter: DataPresenterInterface?
    
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .plain)
        view.register(DataCell.self, forCellReuseIdentifier: DataCell.reuseIdentifier)
        view.delegate = presenter
        view.dataSource = presenter
        view.separatorColor = Asset.separator.color
        view.separatorInset = UIEdgeInsets(
            top: 0,
            left: 50,
            bottom: 0,
            right: 14
        )
        view.backgroundColor = .clear
        return view
    }()
    private lazy var checkButton: UIButton = {
        let button = ViewFactory.Buttons.main(title: "Check IP Data")
        button.addAction(UIAction(handler: { [weak self] action in
            self?.presenter?.checkDidTap()
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        let titleLabel = ViewFactory.label(
            font: FontFamily.Poppins.medium.font(size: 16),
            color: Asset.dark.color
        )
        titleLabel.text = "IP Data"
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
        
        self.view.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(self.tableView.snp.bottom)
            make.left.right.equalToSuperview().inset(18)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(60)
            make.height.equalTo(60)
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

extension DataViewController: DataView {
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func display(checkButtonEnable: Bool) {
        self.checkButton.isEnabled = checkButtonEnable
    }
    
}
