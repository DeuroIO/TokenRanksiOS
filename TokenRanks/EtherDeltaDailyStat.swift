//
//  EtherDeltaDailyStat.swift
//  TokenRanks
//
//  Created by Gelei Chen on 25/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON
struct EtherDeltaDailyStat {
    var token_name : Token!
    var timestamp = ""
    var total_eth_buy = 0
    var total_eth_sell = 0
    var total_kyber_buy = 0
    var total_kyber_sell = 0
    var avg_buy_price = 0.0
    var avg_sell_price = 0.0
    
    static func fromJSON(json:JSON)->EtherDeltaDailyStat{
        let token = Token.fromJSON(json: json["token_name"])
        let timestamp = json["timestamp"].stringValue
        let total_eth_buy = json["total_eth_buy"].numberValue
        let total_eth_sell = json["total_eth_sell"].numberValue
        let total_kyber_buy = json["total_kyber_buy"].numberValue
        let total_kyber_sell = json["total_kyber_sell"].numberValue
        let avg_buy_price = json["avg_buy_price"].numberValue
        let avg_sell_price = json["avg_sell_price"].numberValue
        
        var etherDeltaDailyStat = EtherDeltaDailyStat()
        etherDeltaDailyStat.token_name = token
        etherDeltaDailyStat.timestamp = timestamp
        etherDeltaDailyStat.total_eth_buy = total_eth_buy.intValue
        etherDeltaDailyStat.total_eth_sell = total_eth_sell.intValue
        etherDeltaDailyStat.total_kyber_buy = total_kyber_buy.intValue
        etherDeltaDailyStat.total_kyber_sell = total_kyber_sell.intValue
        etherDeltaDailyStat.avg_buy_price = avg_buy_price.doubleValue
        etherDeltaDailyStat.avg_sell_price = avg_sell_price.doubleValue
        return etherDeltaDailyStat
    }
    
    static func fromJSONArray(value:Any)->[EtherDeltaDailyStat]{
        let json = JSON(value).arrayValue
        var list:[EtherDeltaDailyStat] = []
        for subJSON in json {
            let stat = EtherDeltaDailyStat.fromJSON(json: subJSON)
            list.append(stat)
        }
        return list
    }
}
