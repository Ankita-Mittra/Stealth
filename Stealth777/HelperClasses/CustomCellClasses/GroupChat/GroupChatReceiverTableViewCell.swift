//
//  GroupChatReceiverTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class GroupChatReceiverTableViewCell: UITableViewCell {


    static let identifier = "PrivateChatReceiverTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "PrivateChatReceiverTableViewCell", bundle: nil)
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
