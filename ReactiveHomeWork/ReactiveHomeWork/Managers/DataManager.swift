//
//  DataManager.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 09.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
     
    var dataBase: [String: User] { get set }
}

class DataManager: DataManagerProtocol {
    
    var dataBase: [String: User]
    
    private let user1 = User(login: "user1", password: "123456", contentType: .vehicles)
    private let  user2 = User(login: "user2", password: "qwerty", contentType: .people)
    private let user3 = User(login: "user3", password: "password", contentType: .planets)
    
    init () {
         dataBase = [user1.login : user1,
                                          user2.login : user2,
                                          user3.login : user3]
    }
}
