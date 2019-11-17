//
//  UserModel.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 09.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation

enum UserContentType: String {
    case vehicles = "vehicles"
    case people = "people"
    case planets = "planets"
}

class User {
    var login: String!
    var password: String!
    var contentType: UserContentType
    
    init(login: String, password: String, contentType: UserContentType) {
        self.login = login
        self.password = password
        self.contentType = contentType
    }
}
