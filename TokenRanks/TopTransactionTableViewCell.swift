//
//  TopTransactionTableViewCell.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit

class TopTransactionTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var percantageLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.memoTextView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if let address = addressLabel.text {
            APIFactory.sharedInstance.editAnAccount(account_address: address, memo: textView.text)
        }
    }
}
