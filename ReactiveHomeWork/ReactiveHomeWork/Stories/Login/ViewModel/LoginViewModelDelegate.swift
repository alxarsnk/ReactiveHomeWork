//
//  LoginViewModelDelegate.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 09.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelDelegate: AnyObject {
    
    var login: BehaviorRelay<String> { get set }
    var password: BehaviorRelay<String> { get set }
    
    var errorValue: BehaviorRelay<String> { get set }
    var isSuccess: BehaviorRelay<Bool> { get set }
    
    func validateUser()
}
