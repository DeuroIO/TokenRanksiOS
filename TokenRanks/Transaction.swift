//
//  Transaction.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Transaction {
    var tx_hash = ""
    var timestamp = ""
    var from_account : Account!
    var to_account : Account!
    var quantity = 0
    
    static func fromJSON(json:JSON)->Transaction{
        let tx_hash = json["tx_hash"].stringValue
        let timestamp = json["timestamp"].stringValue
        let from_account = Account.fromJSON(json: json["from_account"])
        let to_account = Account.fromJSON(json: json["to_account"])
        let quantity = json["quantity"].intValue
        
        var t = Transaction()
        t.tx_hash = tx_hash
        t.timestamp = timestamp
        t.from_account = from_account
        t.to_account = to_account
        t.quantity = quantity
        return t
    }
}
