//
//  TableViewDelegate.swift
//  TokenRanks
//
//  Created by Gelei Chen on 14/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit
extension TokenHolderViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.holders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let holder = self.holders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopAccountTableViewCell
        cell.addressLabel.text = holder.account.account_address
        cell.amountLabel.text = holder.top_amount.formattedWithSeparator
        cell.memoTextView.text = holder.account.gussed_name
        cell.rankLabel.text = holder.rank.description
        cell.percantageLabel.text = (Double(holder.top_amount) / Constant.kyberTotalAmountOfTokenDenominator).rounded(toPlaces: 3).description + "%"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopAccountTableViewCell
        if let address = cell.addressLabel.text {
            _ = UIApplication.shared.open(URL(string: "https://etherscan.io/address/\(address)")!, options: [:], completionHandler: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
