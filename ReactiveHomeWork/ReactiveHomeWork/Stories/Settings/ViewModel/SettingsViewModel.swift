//
//  SettingsViewModel.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 14.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SettingsViewModel: SettingsViewModelDelegate {
    
    private let dataManager: DataManagerProtocol = DataManager()
    private let disposeBag = DisposeBag()
    
    var usersArray: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    
    func fetchUsers() {
        usersArray.accept(dataManager.dataBase.map { $0.value }.sorted(by: { (user1, user2) -> Bool in
                return user1.login < user2.login
        }))
    }
    
    func setNewUser(user: User) {
        AuthotizationManager.shared.login(user)
    }
}
