//
//  TransactionsHistoryTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class TransactionsHistoryTableViewCell: UITableViewCell {

    static let identifier = "TransactionsHistoryTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "TransactionsHistoryTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
