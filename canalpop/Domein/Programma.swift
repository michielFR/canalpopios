//
//  Programma.swift
//  canalpop
//
//  Created by Michiel François on 29/10/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class Programma: Codable {
    var id: Int
    var naam: String
    var type:  String
    var rating: Int
    var omschrijving: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case naam
        case type
        case rating
        case omschrijving
    }
    
    init(naam: String, type: String, rating: Int, omschrijving: String, id: Int) {
        self.naam = naam
        self.type = type
        self.rating = rating
        self.omschrijving = omschrijving
        self.id = id
    }
}
