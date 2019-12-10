//
//  ZenderController.swift
//  canalpop
//
//  Created by Michiel François on 19/11/2019.
//  Copyright © 2019 Michiel François. All rights reserved.
//

import Foundation

class APIController {
    static let shared = APIController()
    
    let baseURL = URL(string: "https://canalpop.azurewebsites.net/api/")!
    
    func fetchPopulaireZenders(completion: @escaping ([PopZender]?) -> Void){
        let zenderURL = baseURL.appendingPathComponent("zender/populair")
        let task = URLSession.shared.dataTask(with: zenderURL){
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if  let data = data{
                print(response!)
                print(data)
                if  let zenders = try? jsonDecoder.decode([PopZender].self, from: data){
                    print(zenders)
                    completion(zenders)
                }
            } else {
                print("nil")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchZenders(completion: @escaping ([Zender]?) -> Void){
        let zenderURL = baseURL.appendingPathComponent("zender")
        var request = URLRequest(url: zenderURL)
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let bearerToken = "Bearer " + token
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if  let data = data{
                print(response!)
                print(data)
                if  let zenders = try? jsonDecoder.decode([Zender].self, from: data){
                    print(zenders)
                    completion(zenders)
                }
            } else {
                print("nil")
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    func fetchPopulaireZendersGebruiker(completion: @escaping ([PopZender]?) -> Void){
        let zenderURL = baseURL.appendingPathComponent("zender/popzenders")
        var request = URLRequest(url: zenderURL)
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let bearerToken = "Bearer " + token
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if  let data = data{
                print(response!)
                print(data)
                if  let zenders = try? jsonDecoder.decode([PopZender].self, from: data){
                    print(zenders)
                    completion(zenders)
                }
            } else {
                print("nil")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func rateProgramma(id : Int, rating : Int, completion: @escaping (RatingDTO?) -> Void){
        let zenderURL = baseURL.appendingPathComponent("programma/rate/\(id)/\(rating)")
        var request = URLRequest(url: zenderURL)
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let bearerToken = "Bearer " + token
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if  let data = data{
                print(response!)
                print(data)
                if  let rating = try? jsonDecoder.decode(RatingDTO.self, from: data){
                    print(rating)
                    completion(rating)
                }
            } else {
                print("nil")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchProgrammaRatingGebruiker(_ id : Int, completion: @escaping ([RatingDTO]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "canalpop.azurewebsites.net"
        urlComponents.path = "/api/programma/rated"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: String(id)),
        ]
        var request = URLRequest(url: urlComponents.url!)
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let bearerToken = "Bearer " + token
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if  let data = data{
                print(response!)
                print(data)
                if  let ratings = try? jsonDecoder.decode([RatingDTO].self, from: data){
                    print(ratings)
                    completion(ratings)
                }
            } else {
                print("nil")
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    func login(_ login: Login, completion: @escaping (Int?) -> Void){
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set("", forKey: "username")
        let loginurl = baseURL.appendingPathComponent("account")
        var request = URLRequest(url: loginurl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(login)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8), let response =  response as? HTTPURLResponse{
                    print("data: \(dataString)")
                    UserDefaults.standard.set(dataString, forKey: "token")
                    UserDefaults.standard.set(login.username, forKey: "username")
                    completion(response.statusCode)
                } else {
                    print("nil")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
