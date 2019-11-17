//
//  LoginViewModel.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 09.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: LoginViewModelDelegate {
    
    private let errorMessage = "It was an error"
    
    private let dataManager: DataManagerProtocol = DataManager()
    
    private let disposeBag = DisposeBag()
    
    var login =  BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    
    var errorValue = BehaviorRelay(value: "")
    var isSuccess = BehaviorRelay(value: false)
    
    func validateUser() {
    
        guard password.value == dataManager.dataBase[login.value]?.password else {
            errorValue.accept(errorMessage)
            return
        }
        errorValue.accept("")
        let user = dataManager.dataBase[login.value]!
        AuthotizationManager.shared.login(user)
        isSuccess.accept(true)
    } 
}
