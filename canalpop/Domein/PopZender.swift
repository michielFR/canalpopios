//
//  PopZender.swift
//  canalpop
//
//  Created by Michiel François on 19/11/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

struct PopZender: Codable {
    var id: Int
    var naam: String
    var rating: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case naam
        case rating
    }
    
    init(id: Int, naam: String, rating: Int) {
        self.naam = naam
        self.id = id
        self.rating = rating
    }
}

struct PopZenders: Codable {
    let items: [PopZender]
}

