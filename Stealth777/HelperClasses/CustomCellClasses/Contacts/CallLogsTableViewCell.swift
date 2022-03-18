//
//  CallLogsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class CallLogsTableViewCell: UITableViewCell {
    
    static let identifier = "CallLogsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "CallLogsTableViewCell", bundle: nil)
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
