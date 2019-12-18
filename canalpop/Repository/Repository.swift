//
//  Repository.swift
//  canalpop
//
//  Created by Michiel François on 18/12/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class Repository{
    
    static let shared = Repository()
    let propertyListDecoder = PropertyListDecoder()
    let propertyListEncoder = PropertyListEncoder()

    // MARK: - Archive urls
    let popZenderAlgemeenArchiveUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("popzendersalgemeen").appendingPathExtension("plist")
    
    let popZenderGebruikerArchiveUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("popzendersgebruiker").appendingPathExtension("plist")
    
    let zendersArchiveUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("zenders").appendingPathExtension("plist")
    
    let programmaRatingArchiveUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("programmaratings").appendingPathExtension("plist")
    
    // MARK: - Read & Write popzendersalgemeen
    func readPopZendersAlgemeenFromFile() -> Array<PopZender>{
        if let retrievedPopZenders = try? Data(contentsOf: popZenderAlgemeenArchiveUrl), let decodedPopZenders =  try? propertyListDecoder.decode(Array<PopZender>.self, from: retrievedPopZenders){
            return decodedPopZenders
        }
        return Array<PopZender>()
    }
    
    func writePopZendersAlgemeenToFile(popzenders: Array<PopZender>){
        let encodedPopzenders = try? propertyListEncoder.encode(popzenders)
        try? encodedPopzenders?.write(to: popZenderAlgemeenArchiveUrl, options: .noFileProtection)
    }
    
    // MARK: - Read & Write popzendersGebruiker
    func readPopZendersGebruikerFromFile() -> Array<PopZender>{
        if let retrievedPopZenders = try? Data(contentsOf: popZenderGebruikerArchiveUrl), let decodedPopZenders =  try? propertyListDecoder.decode(Array<PopZender>.self, from: retrievedPopZenders){
            return decodedPopZenders
        }
        return Array<PopZender>()
    }
    
    func writePopZendersGebruikerToFile(popzenders: Array<PopZender>){
        let encodedPopzenders = try? propertyListEncoder.encode(popzenders)
        try? encodedPopzenders?.write(to: popZenderGebruikerArchiveUrl, options: .noFileProtection)
    }
    
    // MARK: - Read & Write zenders met programma's
    func readZendersFromFile() -> Array<Zender>{
        if let retrievedZenders = try? Data(contentsOf: zendersArchiveUrl), let decodedZenders =  try? propertyListDecoder.decode(Array<Zender>.self, from: retrievedZenders){
            return decodedZenders
        }
        return Array<Zender>()
    }
    
    func writeZendersToFile(zenders: Array<Zender>){
        let encodedZenders = try? propertyListEncoder.encode(zenders)
        try? encodedZenders?.write(to: zendersArchiveUrl, options: .noFileProtection)
    }
}
