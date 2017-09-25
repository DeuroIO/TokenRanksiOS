//
//  APIFactory.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _sharedInstance = APIFactory()
struct APIFactory{
    static var sharedInstance = _sharedInstance
}

let serverEndPoint = "http://newbillions.com"
extension APIFactory {
    func requestTopTokenHolder(timestamp:String,coin_address:String,completion: @escaping(_ results:[TopTokenHolder]?)->Void){
        Alamofire.request("\(serverEndPoint)/topTokenHolders/\(timestamp)/\(coin_address)/?format=json", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                print("sucessfully load the requestTopTokenHolder")
                let holders = TopTokenHolder.fromJSONArray(value: value)
                completion(holders)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func requestTopTokenTransactions(timestamp:String,coin_address:String,completion: @escaping(_ results:[TopTokenTransaction]?)->Void){
        Alamofire.request("\(serverEndPoint)/topTokenTransactions/\(timestamp)/\(coin_address)/?format=json", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                let transactions = TopTokenTransaction.fromJSONArray(value: value)
                completion(transactions)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func editAnAccount(account_address:String,memo:String){
        Alamofire.request("\(serverEndPoint)/update_account/\(account_address)/", method: .post, parameters: ["memo":memo], encoding: URLEncoding.httpBody, headers: nil).responseData { (response) in
            switch response.result {
            case .success (let value):
                print("success \(value)")
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
    func getAllTokens(completion: @escaping(_ results:[Token]?)->Void){
        Alamofire.request("\(serverEndPoint)/get_all_tokens", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                let tokens = Token.fromJSONArray(value: value)
                completion(tokens)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func addAToken(name:String,contract_address:String,completion: @escaping(_ results:Bool,_ reason:String)->Void){
        Alamofire.request("\(serverEndPoint)/add_token/\(contract_address)/\(name)", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                let json = JSON(value)
                let status = json["status"].stringValue
                if status != "okay" {
                    let reason = json["reason"].stringValue
                    completion(false, reason)
                } else {
                    completion(true,"succeed")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false,"API request failed")
            }
        }
    }
    
    func requestTopEtherDeltaTransactions(timestamp:String,coin_address:String,completion: @escaping(_ results:[TopEtherDeltaTransaction]?)->Void){
        Alamofire.request("\(serverEndPoint)/topEtherDeltaTransactions/\(timestamp)/\(coin_address)/?format=json", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                let transactions = TopEtherDeltaTransaction.fromJSONArray(value: value)
                completion(transactions)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func requestEtherDeltaDailyStat(timestamp:String,coin_address:String,completion: @escaping(_ results:[EtherDeltaDailyStat]?)->Void){
        Alamofire.request("\(serverEndPoint)/retrive_etherDelta_daily_stat/\(timestamp)/\(coin_address)/?format=json", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                let transactions = EtherDeltaDailyStat.fromJSONArray(value: value)
                completion(transactions)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
