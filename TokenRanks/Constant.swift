//
//  Constant.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit
struct Constant {
    static let kyberTotalAmountOfTokenDenominator = 2260000.0
    
    static func getCurrentDateInString()->String{
        return getDateInString(date: Date())
    }
    
    static func getDateInString(date:Date)->String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static var currentDate = Date()
    static let todayDate = Date()
    static var currentTokenString = ""
    static var currentToken : Token? = nil {
        didSet {
            if let token = currentToken {
                currentTokenString = token.coin_name
            }
        }
    }
    static var tokens : [Token] = [] {
        didSet {
            if tokens.count != 0 {
                Constant.currentToken = tokens[0]
            }
        }
    }
    
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let didGetAllTheTokens = "didGetAllTheTokens"
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
