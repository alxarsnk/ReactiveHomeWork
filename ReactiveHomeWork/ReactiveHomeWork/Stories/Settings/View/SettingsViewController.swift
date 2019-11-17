//
//  SettingsViewController.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 14.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: SettingsViewModelDelegate = SettingsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUsers()
        configureBinding()
    }
    
    private func configureBinding() {
        
       viewModel.usersArray
            .bind(to: tableView.rx.items(cellIdentifier: "userCell")) { row, model, cell in
                cell.textLabel?.text = model.login
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            let user = self.viewModel.usersArray.value[indexPath.row]
            self.viewModel.setNewUser(user: user)
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}
