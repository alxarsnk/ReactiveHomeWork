//
//  AuthorizationManager.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 12.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class AuthotizationManager {
    
    private init() {}
    
    private var user: User!
    
    static var shared = AuthotizationManager()
    
    func login(_ user: User) {
        self.user = user
    }
    
    func getUserInfo() -> BehaviorRelay<(login: String, contentType: UserContentType)> {
        return BehaviorRelay(value:(user.login, user.contentType))
    }
    
}
