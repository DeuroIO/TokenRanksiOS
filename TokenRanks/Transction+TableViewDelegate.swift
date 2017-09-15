//
//  TableViewDelegate.swift
//  TokenRanks
//
//  Created by Gelei Chen on 14/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit
extension TopTransactionViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let transaction = self.transactions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopTransactionTableViewCell
        cell.addressLabel.text = transaction.transaction.to_account.account_address
        cell.quantityLabel.text = transaction.transaction.quantity.formattedWithSeparator
        cell.memoTextView.text = transaction.transaction.to_account.gussed_name
        cell.rankLabel.text = transaction.rank.description
        cell.percantageLabel.text = (Double(transaction.transaction.quantity) / Constant.kyberTotalAmountOfTokenDenominator).rounded(toPlaces: 3).description + "%"
        
        return cell
    }
}
