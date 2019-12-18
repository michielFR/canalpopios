//
//  CanalPopController.swift
//  canalpop
//
//  Created by Michiel François on 18/12/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class CanalPopController{
    static let shared = CanalPopController()
    
    func fetchPopulaireZenders(completion: @escaping ([PopZender]) -> Void){
        
        if(Reachability.isConnected()){
            APIService.shared.fetchPopulaireZenders{ (popzenders) in
                if let popzenders = popzenders {
                    Repository.shared.writePopZendersAlgemeenToFile(popzenders: popzenders)
                    completion(popzenders)
                }
            }
        } else {
            completion(Repository.shared.readPopZendersAlgemeenFromFile())
        }
    }
    
    func fetchZenders(completion: @escaping ([Zender]) -> Void){
        if(Reachability.isConnected()){
            APIService.shared.fetchZenders{
                (zendersService) in
                if let zendersService = zendersService {
                    Repository.shared.writeZendersToFile(zenders: zendersService)
                    completion(zendersService)
                }
            }
        } else {
            completion(Repository.shared.readZendersFromFile())
        }
    }
    
    func fetchPopulaireZendersGebruiker(completion: @escaping ([PopZender]) -> Void){
        if(Reachability.isConnected()){
            APIService.shared.fetchPopulaireZendersGebruiker{
                (popzenders) in
                if let popzenders = popzenders {
                    Repository.shared.writePopZendersGebruikerToFile(popzenders: popzenders)
                    completion(popzenders)
                }
            }
        } else {
            completion(Repository.shared.readPopZendersGebruikerFromFile())
        }
    }
    
    func rateProgramma(id: Int, rating: Int, completion: @escaping (Bool) -> Void){
        if(Reachability.isConnected()){
            APIService.shared.rateProgramma(id: id, rating: rating){
                (ratingDTO) in
                if let ratingDTO = ratingDTO {
                    print(ratingDTO)
                    completion(true)
                }
            }
        }
        completion(false)
    }
}
