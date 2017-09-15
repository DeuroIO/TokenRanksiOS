//
//  TopTableViewCell.swift
//  TokenRanks
//
//  Created by Gelei Chen on 15/9/2017.
//  Copyright © 2017 Gelei. All rights reserved.
//

import UIKit

class TopAccountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var percantageLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
