//
//  RatingDTO.swift
//  canalpop
//
//  Created by Michiel François on 10/12/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class RatingDTO: Codable {
    var id: Int
    var rating: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case rating
    }
    
    init( id: Int, rating: Int) {
        self.id = id
        self.rating = rating
    }
}
