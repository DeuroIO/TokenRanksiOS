//
//  Account.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Account {
    var gussed_name = ""
    var account_address = ""
    
    static func fromJSON(json:JSON)->Account{
        let gussed_name = json["gussed_name"].stringValue
        let account_address = json["account_address"].stringValue
        
        var account = Account()
        account.gussed_name = gussed_name
        account.account_address = account_address
        
        return account
    }
}
