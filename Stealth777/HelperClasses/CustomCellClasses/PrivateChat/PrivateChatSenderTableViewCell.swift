//
//  PrivateChatSenderTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PrivateChatSenderTableViewCell: UITableViewCell {

    static let identifier = "PrivateChatSenderTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "PrivateChatSenderTableViewCell", bundle: nil)
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
