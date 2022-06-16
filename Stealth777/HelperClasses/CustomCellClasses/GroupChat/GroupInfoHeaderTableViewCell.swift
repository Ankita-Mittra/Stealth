//
//  GroupInfoHeaderTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/03/2022.
//

import UIKit

class GroupInfoHeaderTableViewCell: UITableViewHeaderFooterView {

    // MARK: - Outlets & Properties

    static let identifier = "GroupInfoHeaderTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "GroupInfoHeaderTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
}
