//
//  TopTokenTransaction.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TopTokenTransaction {
    var token_name:Token!
    var timestsamp = ""
    var transaction:Transaction!
    var rank = 0
    
    static func fromJSON(json:JSON)->TopTokenTransaction{
        let token = Token.fromJSON(json: json["token_name"])
        let timestamp = json["timestsamp"].stringValue
        let transaction = Transaction.fromJSON(json: json["transaction"])
        let rank = json["rank"].intValue
        
        var topTokenTransaction = TopTokenTransaction()
        topTokenTransaction.token_name = token
        topTokenTransaction.timestsamp = timestamp
        topTokenTransaction.transaction = transaction
        topTokenTransaction.rank = rank
        return topTokenTransaction
    }
    
    static func fromJSONArray(value:Any)->[TopTokenTransaction]{
        let json = JSON(value).arrayValue
        var list:[TopTokenTransaction] = []
        for subJSON in json {
            let holder = TopTokenTransaction.fromJSON(json: subJSON)
            list.append(holder)
        }
        return list
    }
}
