//
//  SettingsViewModelDelegate.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 14.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SettingsViewModelDelegate {
    
    var usersArray: BehaviorRelay<[User]> { get set }
    
    func fetchUsers()
    
    func setNewUser(user: User)
}
