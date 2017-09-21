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

extension APIFactory {
    func requestTopTokenHolder(timestamp:String,completion: @escaping(_ results:[TopTokenHolder]?)->Void){
        Alamofire.request("http://newbillions.com/topTokenHolders/\(timestamp)/?format=json", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
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
    
    func requestTopTokenTransactions(timestamp:String,completion: @escaping(_ results:[TopTokenTransaction]?)->Void){
        Alamofire.request("http://newbillions.com/topTokenTransactions/\(timestamp)/?format=json", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
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
        Alamofire.request("http://newbillions.com/update_account/\(account_address)/", method: .post, parameters: ["memo":memo], encoding: URLEncoding.httpBody, headers: nil).responseData { (response) in
            switch response.result {
            case .success (let value):
                print("success \(value)")
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
    func getAllTokens(completion: @escaping(_ results:[Token]?)->Void){
        Alamofire.request("http://newbillions.com/get_all_tokens", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
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
        Alamofire.request("http://newbillions.com/add_token/\(contract_address)/\(name)", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
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
}
