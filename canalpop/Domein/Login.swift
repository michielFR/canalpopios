//
//  Login.swift
//  canalpop
//
//  Created by Michiel François on 06/12/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class Login: Codable {
    var username: String
    var password:  String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
