//
//  Token.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Token{
    var coin_name = ""
    var contract_address = ""
    
    static func fromJSON(json:JSON)->Token{
        let coin_name = json["coin_name"].stringValue
        let contract_address = json["contract_address"].stringValue
        
        var t = Token()
        t.coin_name = coin_name
        t.contract_address = contract_address
        
        return t
    }
    
    static func fromJSONArray(value:Any)->[Token]{
        
        let json = JSON(value)["results"].arrayValue
        var list:[Token] = []
        for subJSON in json {
            let token = Token.fromJSON(json: subJSON)
            list.append(token)
        }
        return list
    }
}
