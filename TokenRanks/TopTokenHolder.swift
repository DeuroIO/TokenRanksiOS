//
//  TopTokenHolder.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TopTokenHolder {
    var token_name : Token!
    var timestamp = ""
    var account:Account!
    var top_amount = 0
    var rank = 0
    
    static func fromJSON(json:JSON)->TopTokenHolder{
        let token = Token.fromJSON(json: json["token_name"])
        let timestamp = json["timestsamp"].stringValue
        let account = Account.fromJSON(json: json["account"])
        let top_amount = json["top_amount"].intValue
        let rank = json["rank"].intValue
        
        return TopTokenHolder(token_name: token, timestamp: timestamp, account: account, top_amount: top_amount, rank: rank)
    }
    
    static func fromJSONArray(value:Any)->[TopTokenHolder]{
        let json = JSON(value).arrayValue
        var list:[TopTokenHolder] = []
        for subJSON in json {
            let holder = TopTokenHolder.fromJSON(json: subJSON)
            list.append(holder)
        }
        return list
    }
}
