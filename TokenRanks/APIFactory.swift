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
}
