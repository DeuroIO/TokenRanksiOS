//
//  TableViewDelegate.swift
//  TokenRanks
//
//  Created by Gelei Chen on 14/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit
extension AnalyticsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let transaction = self.transactions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopTransactionTableViewCell
        cell.addressLabel.text = transaction.tx_hash
        cell.quantityLabel.text = transaction.eth_quantity.description + " ETH"
        cell.memoTextView.text = transaction.from_account.gussed_name
        cell.rankLabel.text = transaction.rank.description
        cell.percantageLabel.text = (Double(transaction.token_quantity) / Constant.kyberTotalAmountOfTokenDenominator).rounded(toPlaces: 3).description + "%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = self.transactions[indexPath.row].tx_hash
        //        _ = UIApplication.shared.open(URL(string: "https://etherscan.io/tx/\(address)")!, options: [:], completionHandler: nil)
        UIPasteboard.general.string = "https://etherscan.io/tx/\(address)"
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

