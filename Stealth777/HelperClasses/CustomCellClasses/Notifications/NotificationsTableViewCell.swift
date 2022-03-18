//
//  NotificationsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    static let identifier = "NotificationsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "NotificationsTableViewCell", bundle: nil)
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
