//
//  Zender.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class Zender: Codable {
    var id: Int
    var naam: String
    var rating: Int
    var programmas: [Programma]
    
    enum CodingKeys: String, CodingKey {
        case id
        case naam
        case rating
        case programmas
    }
    
    init(naam: String, rating: Int, id: Int, programmas: [Programma]) {
        self.naam = naam
        self.programmas = programmas
        self.id = id
        self.rating = rating
    }
}

class Zenders: Codable {
    let items: [Zender]
}
