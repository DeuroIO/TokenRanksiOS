//
//  TopEtherDeltaTransaction.swift
//  TokenRanks
//
//  Created by Gelei Chen on 25/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TopEtherDeltaTransaction {
    var token_name:Token!
    var tx_hash = ""
    var timestsamp = ""
    var from_account: Account!
    var eth_quantity = 0
    var token_quantity = 0
    var price = 0.0
    var is_buyer = false
    var rank = 0
    
    static func fromJSON(json:JSON)->TopEtherDeltaTransaction{
        let token = Token.fromJSON(json: json["token_name"])
        let tx_hash = (json["tx_hash"].dictionaryValue)["tx_hash"]!.stringValue
        let timestamp = json["timestamp"].stringValue
        let from_account = Account.fromJSON(json: json["from_account"])
        let eth_quantity = json["eth_quantity"].intValue
        let token_quantity = json["token_quantity"].intValue
        let price = json["price"].numberValue
        let is_buyer = json["is_buyer"].boolValue
        
        var topEtherDeltaTransaction = TopEtherDeltaTransaction()
        topEtherDeltaTransaction.token_name = token
        topEtherDeltaTransaction.tx_hash = tx_hash
        topEtherDeltaTransaction.timestsamp = timestamp
        topEtherDeltaTransaction.from_account = from_account
        topEtherDeltaTransaction.eth_quantity = eth_quantity
        topEtherDeltaTransaction.token_quantity = token_quantity
        topEtherDeltaTransaction.price = price.doubleValue
        topEtherDeltaTransaction.is_buyer = is_buyer
        return topEtherDeltaTransaction
    }
    
    static func fromJSONArray(value:Any)->[TopEtherDeltaTransaction]{
        let json = JSON(value).arrayValue
        var list:[TopEtherDeltaTransaction] = []
        var rank = 1
        for subJSON in json {
            var tx = TopEtherDeltaTransaction.fromJSON(json: subJSON)
            tx.rank = rank
            rank = rank + 1
            list.append(tx)
        }
        return list
    }
}
